��    N      �              �  �   �  q   �  [   )  �   �    T  l   Z     �  +   �  %   	  5   5	  _   k	  _   �	  5  +
  )   a  1   �     �  ^  �     $  
   2  
   =     H  W   `  %   �  �   �     k  �   y  �   A  M   
     X  �   d  �     w       z  e   �  !   �  �        �     �  	   	  �        �  F   �  �   =  �     .   �  7   �  '   #     K     f  "   l  >  �     �     �  r   �  !   Z     |  O   �  �  �  �   �  �   J  8   �  A   ,  P   n  P   �  E       V  �   �   f   ~!    �!  .   �"  �   (#     �#    �#     �$  ;   �$  �   %     �%  �  (&  �   (  �   �(  u   x)  +  �)  1  +  �   L,  "   �,  /   �,  +   "-  ?   N-  y   �-  y   .  l  �.  0   �/  =    0     ^0  �  j0     2     (2     42     @2  \   Y2  ,   �2  �   �2     �3  �   �3  �   �4  ]   �5     �5  �   �5  1  �6  �  �7     �9  {   �9  .   G:    v:     ;     �;     �;  �   �;     �<  H   �<  �   �<  �   �=  J   �>  F   ?  %   V?     |?     �?  %   �?  �  �?      PA  	   qA  �   {A  "   B     )B  ]   CB  �  �B  �   �D  �   sE  K   %F  \   qF  _   �F  _   .G  Y   �G  �  �G  �   kI  �   J  I  �J  J   �K  �   :L     �L  $  �L     N  S   -N  �   �N  �   NO   *R-Administrator*: A user account with this Role has access to all operations provided by the REST API, with the exception of key usage operations, i.e. message signing and decryption. *R-Backup*: A user account with this Role has access to the operations required to initiate a system backup only. *R-Metrics*: A user account with this Role has access to read-only metrics operations only. *R-Operator*: A user account with this Role has access to all key usage operations, a read-only subset of key management operations and user management operations allowing changes to their own account only. A new NetHSM needs to be provisioned first with passphrases and the current time. The *Admin Passphrase* is the *Administrator*’s passphrase, which is the super user of the NetHSM. The *Unlock Passphrase* is used to encrypt NetHSM’s confidential data store. A public NetHSM demo instance is available at `nethsmdemo.nitrokey.com <https://nethsmdemo.nitrokey.com>`__. Accessing a NetHSM instance Accessing a NetHSM using the PKCS#11 driver Accessing a NetHSM using the REST API Accessing a NetHSM with the nitropy command line tool After creating a key (here: ID 23) with the according mechanism, you can use it for decryption: After creating a key (here: ID 42) with the according mechanism, you can use it for decryption: Alternatively you can run the `NetHSM Docker container <https://hub.docker.com/r/nitrokey/nethsm>`__ locally. The NetHSM container requires nested virtualization for strong separation with other containers. Thus, to start a NetHSM container you need a Linux host with /dev/kvm available. Execute this command: Alternatively, you can cancel the update: And then use ``openssl`` to verify the signature: Backups Before we start, we store the host name of the NetHSM instance in the ``NETHSM_HOST`` environment variable.  You can use the public NetHSM demo instance ``nethsmdemo.nitrokey.com`` or run a local demo instance using the NetHSM docker image, see the `Development and Testing </index.html#development-and-testing>`_ section of the NetHSM documentation. Create a User Decrypting Decryption Development and Testing Download the `PKCS#11 driver <https://github.com/Nitrokey/nethsm-pkcs11>`__ for NetHSM. First, let’s see what we have here: For a complete list of available key algorithms and key mechanisms, see the API documentation for the KeyAlgorithm_ and KeyMechanism_ types. Generate Keys If you use a NetHSM demo instance with a self-signed certificate, for example using the Docker image, you will have to use the ``--insecure``/``-k`` option for ``curl`` to skip the certificate check. If you use a NetHSM demo instance with a self-signed certificate, for example using the Docker image, you will have to use the ``--no-verify-tls`` option for ``nitropy`` to skip the certificate check. If you want to continue with the installation, you can now commit the update: Import Keys In *Attended Boot* mode the *Unlock Passphrase* needs to be entered during each start which is used to encrypt the data store. For security reasons this mode is recommended. In *Unattended Boot* mode no Unlock Passphrase is required, therefore the NetHSM can start unattended and the data store is stored unencrypted. Use this mode if your availability requirements can’t be fulfilled with *Attended Boot* mode. In this guide, we want to use an RSA key to decrypt data using PKCS #1 and to sign data with PSS using SHA256.  So let’s generate a new key on the NetHSM. Make sure to use the ``RSA`` algorithm and to select the ``RSA_Signature_PSS_SHA256`` and ``RSA_Decryption_PKCS1`` key mechanisms.  If you don’t specify a key ID, the NetHSM will generate a random ID for the new key. Initialization Instead of generating a key on the NetHSM, you can also import existing private keys into the NetHSM: Integration to Custom Application It is possible to crate a backup of the NetHSM that captures both the configuration and the stored keys.  In order to create a backup, you first have to set a backup passphrase that is used to encrypt the backup file: Key Management Key Operations List Keys Modify the configuration file ``p11nethsm-config.yaml`` according to your setup (e.g. address, operator name) and store it in ``$HOME/.nitrokey``, ``/etc/nitrokey/``, or in the folder where your application is executed. NetHSM NetHSM can be used in *Attended Boot* mode and *Unattended Boot* mode. Note: In a future release another Role will be implemented which is allowed to /keys/ POST, /keys/generate POST, /keys/{KeyID} PUT & DELETE, /keys/{KeyID}/cert PUT & DELETE in addition to what R-Operator is allowed to do. Now create a new user with the operator role that can be used to sign and decrypt data.  Note that the NetHSM assigns a random user ID if we don’t specify it. Now we can use the NetHSM to decrypt the data: Now you have to create a user with the *R-Backup* role: Or switch back to *Attended Boot* mode: Retrieve the current mode: Roles See what the device’s status is: Separation of duties can be implemented by using the available Roles. Each user account configured on the NetHSM has one of the following Roles assigned to it. Following is a high-level description of the operations allowed by individual Roles, for endpoint-specific details please refer to the REST API documentation. Show Key Details Signing Similarily, we can sign data using the key on the NetHSM.  For RSA and ECDSA, we have to calculate a digest first: Switch to *Unattended Boot* mode: TODO: fix example The NetHSM demo instance at ``nethsmdemo.nitrokey.com`` is already provisioned. The NetHSM supports RSA, ED25519 and ECDSA keys.  When creating a key, you have to select both the key algorithm and the key mechanisms to use.  RSA keys can be used for decryption (with the modes raw, PKCS #1 and OAEP with MD5, SHA1, SHA224, SHA256, SHA384 or SHA512) and for signatures (with the modes PKCS #1 and PSS with MD5, SHA1, SHA224, SHA256, SHA384 or SHA512).  The other algorithms only support the signature mechanism. The ``-i``/``--include`` option causes ``curl`` to print the HTTP status code and the response headers.  The ``-w '\n'``/``--write-out '\n'`` option adds a newline after the response body. The generated client code, in this example JavaScript, will be created in the ``./out/`` directory. This folder also contains the necessary documentation how to use it. Then can you generate the backup and write it to a file: Then we can create a signature from this digest using the NetHSM: Then you can generate the NetHSM client for your programming language like this: These guides explain how to access a NetHSM using three three different methods: This backup file can be restored on an unprovisioned NetHSM instance: This tutorial demonstrates how to access the NetHMS via REST API. The interface is `documented here <https://nethsmdemo.nitrokey.com/api_docs/index.html#docs/summary/summary>`__ and it's specification is available as `RAML <https://nethsmdemo.nitrokey.com/api_docs/nethsm-api.raml>`__ and as `OpenAPI (Swagger) <https://nethsmdemo.nitrokey.com/api_docs/gen_nethsm_api_oas20.json>`__. This tutorial demonstrates how to access the NetHMS via `nitropy <https://github.com/Nitrokey/pynitrokey>`__ command line tool, which you need to download and install. To be able to use the key with ``openssl``, we export it as a PEM file and store it as ``public.pem``: To integrate the NetHSM into own custom applications client libraries are available for almost all programming languages, including JavaScript, C++ and Python for example. Therefore we recommend using `OpenAPI Generator <https://github.com/OpenAPITools/openapi-generator>`__. To list all the available languages, you enter To make sure that the key has been created and has the correct algorithm and mechanism settings, we can query all keys on the NetHSM: Updates Updates for the NetHSM can be installed in a two-step process.  First you have to upload the update image to the NetHSM.  The image is then checked and validated.  If the validation is successful, the release notes for the update are returned by the NetHSM: User Management We can also query the public key of the generated key pair: We can encrypt data for the key stored on the NetHSM using ``openssl``. (``public.pem`` is the public key file that we created in the `Show Key Details`_ section.) We can inspect the key with ``openssl`` and use it for encryption or signature verification (as described in the next section): Project-Id-Version: Nitrokey Documentation
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2021-05-08 14:42+0200
PO-Revision-Date: 2021-05-08 14:40+0000
Last-Translator: Anonymous <noreply@weblate.org>
Language: fr
Language-Team: French <https://translate.nitrokey.com/projects/nitrokey-documentation/documentation-nethsm/fr/>
Plural-Forms: nplurals=2; plural=n > 1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.6.0
 *R-Administrateur* : Un compte utilisateur doté de ce rôle a accès à toutes les opérations fournies par l'API REST, à l'exception des opérations d'utilisation des clés, c'est-à-dire la signature et le décryptage des messages. *R-Backup* : Un compte utilisateur avec ce rôle a accès aux opérations requises pour initier une sauvegarde du système uniquement. *R-Metrics* : Un compte utilisateur avec ce rôle a accès aux opérations de métriques en lecture seule uniquement. *R-Opérateur* : Un compte d'utilisateur avec ce rôle a accès à toutes les opérations d'utilisation des clés, à un sous-ensemble d'opérations de gestion des clés en lecture seule et à des opérations de gestion des utilisateurs permettant des changements uniquement pour leur propre compte. Un nouveau NetHSM doit d'abord être approvisionné avec des phrases de passe et l'heure actuelle. La *Admin Passphrase* est la phrase de passe de l'*Administrator*, qui est le super utilisateur du NetHSM. La *Unlock Passphrase* est utilisée pour crypter le magasin de données confidentielles du NetHSM. Une instance de démonstration publique de NetHSM est disponible à `nethsmdemo.nitrokey.com <https://nethsmdemo.nitrokey.com>`__. Accéder à une instance de NetHSM Accès à un NetHSM à l'aide du pilote PKCS#11 Accès à un NetHSM à l'aide de l'API REST Accéder à un NetHSM avec l'outil de ligne de commande nitropy Après avoir créé une clé (ici : ID 23) avec le mécanisme correspondant, vous pouvez l'utiliser pour le décryptage : Après avoir créé une clé (ici : ID 42) avec le mécanisme correspondant, vous pouvez l'utiliser pour le décryptage : Vous pouvez également exécuter le conteneur Docker `NetHSM <https://hub.docker.com/r/nitrokey/nethsm>`__ localement. Le conteneur NetHSM nécessite une virtualisation imbriquée pour une séparation forte avec les autres conteneurs. Ainsi, pour démarrer un conteneur NetHSM, vous avez besoin d'un hôte Linux avec /dev/kvm disponible. Exécutez cette commande : Vous pouvez également annuler la mise à jour : Et ensuite utiliser ``openssl`` pour vérifier la signature : Sauvegardes Avant de commencer, nous enregistrons le nom d'hôte de l'instance NetHSM dans la variable d'environnement ``NETHSM_HOST``.  Vous pouvez utiliser l'instance de démonstration publique de NetHSM ``nethsmdemo.nitrokey.com`` ou exécuter une instance de démonstration locale en utilisant l'image docker de NetHSM, voir la section `Development and Testing </index.html#development-and-testing>`_ de la documentation de NetHSM. Créer un utilisateur Décryptage Décryptage Développement et essais Téléchargez le pilote `PKCS#11 <https://github.com/Nitrokey/nethsm-pkcs11>`__ pour NetHSM. Tout d'abord, voyons ce que nous avons ici : Pour obtenir une liste complète des algorithmes et des mécanismes de clé disponibles, consultez la documentation de l'API pour les types KeyAlgorithm_ et KeyMechanism_. Générer des clés Si vous utilisez une instance de démonstration NetHSM avec un certificat auto-signé, par exemple en utilisant l'image Docker, vous devrez utiliser l'option ``--insecure``/``-k`` pour ``curl`` afin d'ignorer la vérification du certificat. Si vous utilisez une instance de démonstration NetHSM avec un certificat auto-signé, par exemple en utilisant l'image Docker, vous devrez utiliser l'option ``--no-verify-tls`` pour ``nitropy`` afin d'éviter la vérification du certificat. Si vous souhaitez poursuivre l'installation, vous pouvez maintenant valider la mise à jour : Clés d'importation En mode *Attended Boot*, la *Unlock Passphrase* doit être saisie à chaque démarrage et est utilisée pour crypter la mémoire de données. Pour des raisons de sécurité, ce mode est recommandé. En mode *Démarrage sans surveillance*, aucune phrase de passe de déverrouillage n'est requise, le NetHSM peut donc démarrer sans surveillance et la mémoire de données est stockée en clair. Utilisez ce mode si vos exigences de disponibilité ne peuvent être satisfaites avec le mode *Attended Boot*. Dans ce guide, nous voulons utiliser une clé RSA pour déchiffrer des données en utilisant PKCS #1 et pour signer des données avec PSS en utilisant SHA256.  Générons donc une nouvelle clé sur le NetHSM. Assurez-vous d'utiliser l'algorithme ``RSA`` et de sélectionner les mécanismes de clé ``RSA_Signature_PSS_SHA256`` et ``RSA_Décryptage_PKCS1``.  Si vous ne spécifiez pas d'ID de clé, le NetHSM générera un ID aléatoire pour la nouvelle clé. Initialisation Au lieu de générer une clé sur le NetHSM, vous pouvez également importer des clés privées existantes dans le NetHSM : Intégration à une application personnalisée Il est possible de créer une sauvegarde du NetHSM qui capture à la fois la configuration et les clés stockées.  Pour créer une sauvegarde, vous devez d'abord définir une phrase de passe de sauvegarde qui est utilisée pour chiffrer le fichier de sauvegarde : Gestion des clés Opérations clés Clés de liste Modifiez le fichier de configuration ``p11nethsm-config.yaml`` selon votre configuration (par exemple adresse, nom de l'opérateur) et stockez-le dans ``$HOME/.nitrokey``, ``/etc/nitrokey/``, ou dans le dossier où votre application est exécutée. NetHSM NetHSM peut être utilisé en mode *Attended Boot* et *Unattended Boot*. Note : Dans une future version, un autre rôle sera implémenté qui sera autorisé à /keys/ POST, /keys/generate POST, /keys/{KeyID} PUT & DELETE, /keys/{KeyID}/cert PUT & DELETE en plus de ce que R-Operator est autorisé à faire. Créez maintenant un nouvel utilisateur avec le rôle d'opérateur qui pourra être utilisé pour signer et décrypter les données.  Notez que le NetHSM attribue un ID utilisateur aléatoire si nous ne le spécifions pas. Maintenant, nous pouvons utiliser le NetHSM pour décrypter les données : Maintenant vous devez créer un utilisateur avec le rôle *R-Backup* : Ou repassez en mode *Attended Boot* : Récupère le mode actuel : Rôles Voir quel est l'état de l'appareil : La séparation des tâches peut être mise en œuvre en utilisant les rôles disponibles. Chaque compte utilisateur configuré sur le NetHSM se voit attribuer l'un des rôles suivants. Voici une description de haut niveau des opérations autorisées par les rôles individuels, pour les détails spécifiques aux points de terminaison, veuillez vous référer à la documentation de l'API REST. Afficher les détails de la clé Signature De même, nous pouvons signer des données en utilisant la clé du NetHSM.  Pour RSA et ECDSA, nous devons d'abord calculer un condensé : Passez en mode *Unattended Boot* : TODO : corriger l'exemple L'instance de démonstration de NetHSM à "nethsmdemo.nitrokey.com" est déjà provisionnée. Le NetHSM prend en charge les clés RSA, ED25519 et ECDSA.  Lors de la création d'une clé, vous devez sélectionner à la fois l'algorithme de clé et les mécanismes de clé à utiliser.  Les clés RSA peuvent être utilisées pour le décryptage (avec les modes raw, PKCS #1 et OAEP avec MD5, SHA1, SHA224, SHA256, SHA384 ou SHA512) et pour les signatures (avec les modes PKCS #1 et PSS avec MD5, SHA1, SHA224, SHA256, SHA384 ou SHA512).  Les autres algorithmes ne supportent que le mécanisme de signature. L'option `-i``/``--include`` permet à `curl`` d'imprimer le code d'état HTTP et les en-têtes de réponse.  L'option ``-w '\n'``/``--write-out '\n'`` ajoute une nouvelle ligne après le corps de la réponse. Le code client généré, dans cet exemple JavaScript, sera créé dans le répertoire `./out/``. Ce dossier contient également la documentation nécessaire à son utilisation. Ensuite, vous pouvez générer la sauvegarde et l'écrire dans un fichier : Nous pouvons ensuite créer une signature à partir de ce condensé en utilisant le NetHSM : Vous pouvez ensuite générer le client NetHSM pour votre langage de programmation comme ceci : Ces guides expliquent comment accéder à un NetHSM en utilisant trois méthodes différentes : Ce fichier de sauvegarde peut être restauré sur une instance NetHSM non provisionnée : Ce tutoriel démontre comment accéder au NetHMS via l'API REST. L'interface est `documentée ici <https://nethsmdemo.nitrokey.com/api_docs/index.html#docs/summary/summary>`__ et sa spécification est disponible comme `RAML <https://nethsmdemo.nitrokey.com/api_docs/nethsm-api.raml>`__ et comme `OpenAPI (Swagger) <https://nethsmdemo.nitrokey.com/api_docs/gen_nethsm_api_oas20.json>`__. Ce tutoriel montre comment accéder au NetHMS via l'outil de ligne de commande `nitropy <https://github.com/Nitrokey/pynitrokey>`__, que vous devez télécharger et installer. Pour pouvoir utiliser la clé avec ``openssl``, nous l'exportons sous forme de fichier PEM et la stockons sous le nom de ``public.pem`` : Pour intégrer le NetHSM dans ses propres applications personnalisées, des bibliothèques clientes sont disponibles pour presque tous les langages de programmation, dont JavaScript, C++ et Python par exemple. Nous vous recommandons donc d'utiliser le générateur `OpenAPI <https://github.com/OpenAPITools/openapi-generator>`__. Pour obtenir la liste de toutes les langues disponibles, vous devez entrer Pour s'assurer que la clé a été créée et que les paramètres de l'algorithme et du mécanisme sont corrects, nous pouvons interroger toutes les clés du NetHSM : Mises à jour Les mises à jour du NetHSM peuvent être installées en deux étapes.  Vous devez d'abord télécharger l'image de mise à jour sur le NetHSM.  L'image est ensuite vérifiée et validée.  Si la validation est réussie, les notes de version de la mise à jour sont renvoyées par le NetHSM : Gestion des utilisateurs Nous pouvons également demander la clé publique de la paire de clés générée : Nous pouvons chiffrer les données pour la clé stockée sur le NetHSM en utilisant ``openssl``. (``public.pem`` est le fichier de clé publique que nous avons créé dans la section `Show Key Details`_). Nous pouvons inspecter la clé avec ``openssl`` et l'utiliser pour le cryptage ou la vérification de signature (comme décrit dans la section suivante) : 