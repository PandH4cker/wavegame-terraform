# Infrastructure AWS "A la demande"

Le code Terraform suivant permet d'automatiser la construction de l'infrastructure AWS de "A la demande".

Prérequis :
- Installer Terraform
- Installer la CLI AWS
- Configurer son provider

Remarque : 
- La création des ressources prend une quinzaine de minutes
- Le provisionnement des instances ec2 met quelques minutes avant que les applications soient fonctionnelles une fois les instances créées
- Attention à contrôler votre budget, des alertes ont été mises en place pour bloquer le compte en cas de dépassement
- N'oubliez pas de "détruire" vos ressources le soir ou lorsque vous ne travaillez pas pour réduire les coûts
- La ressource NAT Gateway est une ressource coûteuse qui est seulement utilisée lors du provisionnement des instances EC2. Il est recommandé de supprimer cette ressource une fois que les applications sont fonctionnelles en commentant le code correspondant dans le fichier vpc.tf et en relançant un terraform "apply" pour l'enlever. Il sera nécessaire de le décommenter que lorsque les instances ec2 doivent être reconstruites.

Tips : 
- Un accès console peut-être récupéré en créant le mot de passe de votre compte BlueWaver
  `aws iam create-login-profile --user-name BlueWaver --password <new-password> --profil <profile>`
- Il peut-être utile de configurer un remote backend terraform pour travailler en groupe avec un tfstate partagé

Commandes utiles :
|                   |                                        |
|-------------------|----------------------------------------|
| terraform apply   | Création des ressources                |
| terraform destroy | Destruction des ressources             |
| aws configure     | Configuration du profil aws par défaut |