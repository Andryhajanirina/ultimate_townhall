# Envoi d'emails en masse

Ce projet te donnera les compétences de manipuler des gems à la fois, et de faire des beaux rapprochements pour des programmes stylays.
1. Note importante

Ce projet devra être fait en équipe. C'est à dire que ton équipe complète devra participer au projet, et chacun devra contribuer en faisant une partie bien précise. Le projet rendu sera un repo Github commun à l'équipe.

Ce type de projet vous permettra d'apprendre à travailler ensemble. C'est indispensable pour le monde du travail, et c'est un excellent entrainement pour les projets plus conséquents de la formation. Comme il y a beaucoup à faire, il faudra bien vous répartir les tâches.
2. Résumé du projet

Ce projet sera un récapitulatif de tout ce que vous avez appris jusqu'à présent : vous allez scrapper, enregistrer dans un spreadsheet, puis envoyer des emails, avec une relance par Twitter. Le tout dans un dossier ruby bien rangé, en POO.

Le projet consistera en gros à contacter toutes les mairies de France pour que ces dernières parlent de THP. Qui sait, ptet que grâce à vous on aura The Hacking Project dans une ferme de la Creuse ❤️
3. Le projet, en détails

Le CEO de get-email-corp est vraiment ravi de ton travail. Il veut donc monter une équipe de hackeurs et vous nommer en charge de la filliale send-email-corp, qui vient de décrocher un contrat à 300k€ pour une startup qui s'appelle The Hacking Project. Votre mission est d'envoyer un email à toutes les mairies de trois départements de votre choix et de leur dire qu'ils devraient monter un groupe THP dans leur commune.

⚠️ Il est à noter qu'il est INTERDIT de le faire pour le département du Val d'Oise (ainsi que pour le 75 qui n'a pas assez de mairies). Le but est d'apprendre, pas de copier-coller 😉
3.1. Le scrappeur

Le programme de scrappeur devra récupérer les emails de trois départements choisis arbitrairement par vous. Puis il devra enregistrer ces emails dans un fichier CSV/JSON. Pour chaque mairie, il devra y mettre :

    l'email
    Le nom de la commune
    Le département (numéro ou nom)

3.2. Envoyer les emails

Le programme d'envoi d'emails va reprendre chaque colonne de ton CSV/JSON et enverra un bel email à la mairie indiquée. Pour ceux qui ont peur d'utiliser leur adresse Gmail perso, vous êtes bien entendu libres d'utiliser une adresse d'une fausse personne, comme par exemple "Théophile Coutaind", vous n'aurez qu'à nous transférer les emails vers nous. Évidemment, on vous conseille de tester sur des BDDs en bois avec vos adresses emails, avant d'envoyer la sauce

``Bonjour,
Je m'appelle [PRÉNOM], je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de ntore école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.

Déjà 500 personnes sont passées par The Hacking Project. Est-ce que la mairie de [NOM_COMMUNE] veut changer le monde avec nous ?


Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80``

3.4. Petite relance Twitter

Un programme qui n'envoie que des emails, c'est un appel à pas de réponse 😢 Nous allons donc mettre en place une stratégie pour faire en sorte que les mairies se souviennent de nous avec un petit ping sur Twitter.

Le bot Twitter aura deux parties :

    Un premier programme qui va repasser sur chaque élément du CSV/JSON et ajouter une colonne supplémentaire avec le handle twitter
        une recherche avec mairie [NOM_COMMUNE] en prenant le premier résultat devrait faire l'affaire ;)
    Un second programme qui prend la colonne des handle Twitter, et qui follow les users concernés. Avec un compte genre "Apprendre à coder" c'est pas mal

4. Structure du dossier
4.1. Dotenv

Dans ce programme, vous allez manipuler des clés d'API. Une clé d'API ne se met JAMAIS dans un répository GitHub. Pour ce programme, vous allez devoir passer par Dotenv pour gérer les clés d'API.
4.2. Les fichiers que l'on doit retrouver

Le dossier aura plein de fichiers et dossier, mais une bonne organisation vous permettra de vous y retrouver facilement. Voici une organisation à titre indicatif : la base a été mise dans un dossier à part, puis les programmes répartis selon les grandes lignes. Vous les views, je vous conseille de faire comme vous le sentez ✌️

``ultimate_townhall
├── .gitignore
├── .env (pas sur le répo GitHub, bien entendu 😉)
├── README.md
├── Gemfile
├── Gemfile.lock
├── app.rb
├── db
│   └── townhalls.csv
└── lib
    ├── app
    │   ├── townhalls_scrapper.rb
    │   ├── townhalls_mailer.rb
    │   ├── townhalls_adder_to_db.rb
    │   └── townhalls_follower.rb
    └── views
        ├── done.rb
        └── index.rb
        ``

# Contributeur et Rôles

    Une personne qui s'occupe du scrappeur
    Une personne qui s'occupe du mailer
    Une personne qui s'occupe du bot Twitter
    Une personne qui fait les views, et qui s'arrange pour lier tous les programmes entre eux et faire en sorte qu'ils marchent