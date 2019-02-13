PROJET DE MÉLANIE NGUON ET VIVIANE DE PÉTIGNY

# A quoi ça sert ?
 Créer des évènements et inviter des gens !

# Comment on installe ?
 Très simple : 
  1. Utilise tes clés API sendgrid dans un fichier '.env' à la racine du dossier
  2. Petit 'bundle install'
  3. la série : 'rails db:create // rails db:migrate // rails db:seed'

# Comment on s'en check ? 
 On s'amuse avec la console pardis! 
 1. Les tables : 'tp User.all / tp Event.all / tp Attendance.all'
 2. Les associations genre 'Attendance.first.event.administrator.first_name' ou 'Event.first.attendees'

# Comment on check les supers mails ?
 Direction yopmail : 'dauphineforever@yopmail.com' !!!! (oubliez pas de rafraichir la page!!!)

# Comment apporter sa pierre à l'édifice ?
## Créer votre utilisateur ! 
  'moi = User.create(first_name:"MonPrénom", last_name:"MonNomDeFamille", description:"Je suis Moi", email:"dauphineforever@yopmail.com", encrypted_password:"coucoutoi...")'
## Créer votre évènement ! 
  'party = Event.create(title:"Soirée Pilou Poilu", description:"Promis on se couche tôt et on te fait pas chier", price:5, location:"Manor di Petinisme", start_date:"30/05/2019", duration:20, administrator:moi)'
## Créer votre participation !
  'iamin = Attendance.create(stripe_customer_id:"999999", event: party, attendee: User.all.sample)'
  


# Par ici la prod!!!!
  
  https://calm-river-18731.herokuapp.com/




