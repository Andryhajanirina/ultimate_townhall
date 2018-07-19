require 'nokogiri'
require 'open-uri'
require 'json'
require 'csv'
require 'google_drive'
require 'dotenv'

Dotenv.load

tab_urls_departement = ["http://annuaire-des-mairies.com/guyane.html",
                    "http://annuaire-des-mairies.com/lozere.html",
                    "http://annuaire-des-mairies.com/territoire-de-belfort.html"]

tab_nom_departement = ["Departement de Guyanne", "Departement de Lozère", "Departement de Belfort"]

infos_departements = Hash[tab_urls_departement.zip(tab_nom_departement)]


$count_file = 0

# liste_communes = "http://annuaire-des-mairies.com/val-d-oise.html"
infos_departements.each do |liste_communes, nom_departement|


    # Méthode  pour récupérer un email
    def get_the_email_of_a_townhal_from_its_webpage(url)
        page = Nokogiri::HTML(open(url))
        email = page.css('tr.tr-last td')[7].text
        return email
    end


    # Méthode qui récupère la liste des 
    def get_all_the_liste_url_commune_of_val_doise_townhalls(liste_communes)
        page = Nokogiri::HTML(open(liste_communes))
        domaine = "http://annuaire-des-mairies.com/"

        ville = {}

        links = page.css("a.lientxt")
        links.each do |link|
            
            lien = link['href']
            nom_commune = link.text

            link_updated = lien.gsub(/(\.\/)/, "")
            last_link = domaine + link_updated

            ville[nom_commune] = last_link  
        end
        return ville
    end

    tab_ville = get_all_the_liste_url_commune_of_val_doise_townhalls(liste_communes)

    # Méthode qui récupère les emails pour chaque commune de Val-d-Oise
    def get_email_par_ville(tableau_hash)
        tab_ville = []
        tab_email = []
        tableau_hash.each do |ville, url|
            tab_ville << ville
            tab_email << get_the_email_of_a_townhal_from_its_webpage(url)
        end

        ville = Hash[tab_ville.zip(tab_email)]
        return ville
    end

    # Enregistre les emails dans le fichier JSON
    def save_to_json(tableau)
        tab_email = get_email_par_ville(tableau)
        File.open("../db/townhalls#{$count_file}.json", "a") do |f|
            f.write(tab_email.to_json)
        end
    end

    # Enregistrement des emails dans le spreedsheet
    def save_to_spreedsheet(nom_departement)
        # tab_email = get_email_par_ville(hash_array)
        file_json = open("../db/townhalls#{$count_file}.json")
        json = file_json.read
        
        tab_email = JSON.parse(json)

        session = GoogleDrive::Session.from_config("../config.json")
        feuille_spreedsheet = session.spreadsheet_by_key("1SM4QNGm3l65t65VR881Zk7AcqEZTlV7qvAkah4vVGp8").worksheets[0]
        
        # Mettre l'entête du tableau [1, 1] = cellule a1
        # Mettre l'entête du tableau [1, 2] = cellule b1
        feuille_spreedsheet[1, 1] = "Département"
        feuille_spreedsheet[1, 2] = "Mairie"
        feuille_spreedsheet[1, 3] = "Email"

        i = 2 # car la premiere ligne contient les titres, les infos commencent à la ligne 2
        count_dep = 0

        tab_email.each do |mairie, email|
            feuille_spreedsheet[i, 1] = nom_departement
            feuille_spreedsheet[i, 2] = mairie
            feuille_spreedsheet[i, 3] = email
            feuille_spreedsheet.save # permet de modifier et d'enregistrer le spreadsheet
            i += 1 # permet de passesr à la ligne suivante
        end
    end

    # Enregistrement des emails dans le spreedsheet
    def save_to_csv(hash_array)
        # tab_email = get_email_par_ville(hash_array)


        file_json = open("../db/townhalls#{$count_file}.json")
        json = file_json.read
        
        tab_email = JSON.parse(json)

        # Mettre l'entête du tableau [1, 1] = cellule a1
        # Mettre l'entête du tableau [1, 2] = cellule b1
        header = ["VILLE", "EMAIL"]
        

        CSV.open("../db/townhalls#{$count_file}.csv", "wb") do |file|
            file << header
            tab_email.map { |contenu| file << contenu }
        end
    end


    def perform(tableau)
        puts "============================================="
        puts "LANCEMENT DU PROGRAMME, VEUILLEZ PATIENTER..."
        puts "============================================="
            puts "Ecriture dans le fichier json n°#{$count_file+1}..."
                save_to_json(tableau)
            puts "Fin des écritures dans le fichier json n°#{$count_file+1}"

            puts "Ecriture dans le fichier spreedsheet n°#{$count_file+1}..."
                save_to_spreedsheet(tableau)
            puts "Fin des écritures dans le fichier spreedsheet n°#{$count_file+1}"

            puts "Ecriture dans le fichier CSV n°#{$count_file+1}..."
                save_to_csv(tableau)
            puts "Fin des écritures dans le fichier CSV n°#{$count_file+1}"
            
        puts "============================================="
        puts "FIN DU PROGRAMME, MERCI D'AVOIR  PATIENTER!!!"
        puts "============================================="
    end
    puts "Récupération des listes des urls des communes"
    perform(tab_ville)
    $count_file += 1
end    
  


    #tab_ville = get_all_the_liste_url_commune_of_val_doise_townhalls(liste_communes)
    # Lancement du programme

