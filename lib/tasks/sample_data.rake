namespace :db do
  desc 'Drop, create, migrate, seed and populate sample data'
  task prepare: [:drop, :create, :migrate, :seed, :populate_sample_data] do
    puts 'Ready to go!'
  end

  desc 'Populates the database with sample data'
  task populate_sample_data: :environment do
#    10.times { User.create!(email: Faker::Internet.email) }
    # Create Users
    
    User.create!(first_name: 'Daniel', last_name:'Graf', username: 'danielgraf', email:'danielgraf@palaumoe.net', password:'password')
    User.last.add_role 'admin'
    
    User.create!(first_name: 'Marcia', last_name:'Inacio', username: 'marciainacio', email:'marciainacio@palaumoe.net', password:'password')
    User.last.add_role 'specialist'
    
    User.create!(first_name: 'Vivian', last_name:'Ngirngetrang', username: 'vivianngirngetrang', email:'vivianngirngetrang@palaumoe.net', password:'password')
    User.last.add_role 'specialist'
    
    User.create!(first_name: 'Edwel', last_name:'Ongrung', username: 'edwel', email:'edwel@palaumoe.net', password:'password')
    User.last.add_role 'admin'
    
    User.create!(first_name: 'TES', last_name:'Admin', username: 'tesadmin', email:'tesadmin@palaumoe.net', password:'password')
    User.last.add_role 'admin'
    
    
    
    # Create Schools
    School.create!(name:'Aimeliik Elementary School', state:'Aimeliik')
    School.create!(name:'Airai Elementary School', state:'Airai')
    School.create!(name:'Angaur Elementary School', state:'Angaur')
    School.create!(name:'George B. Harris Elementary School', state:'Koror')
    School.create!(name:'Ibobang Elementary School', state:'Ngatpang')
    School.create!(name:'JFK Elementary School', state:'Kayangel')
    School.create!(name:'Koror Elementary School', state:'Koror')
    School.create!(name:'Melekeok Elementary School', state:'Melekeok')
    School.create!(name:'Meyuns Elementary School', state:'Koror')
    School.create!(name:'Ngaraard Elementary School', state:'Ngaraard')
    School.create!(name:'Ngarchelong Elementary School', state:'Ngarchelong')
    School.create!(name:'Ngardmau Elementary School', state:'Ngardmau')
    School.create!(name:'Ngeremlengui Elementary School', state:'Ngeremlengui')
    School.create!(name:'Palau High School', state:'Koror')
    School.create!(name:'Peleliu Elementary School', state:'Peleliu')
    School.create!(name:'Hatohobei Elementary School', state:'Hatohobei')
    School.create!(name:'Pulo Anna Elementary School', state:'Sonsorol')
    School.create!(name:'Sonsorol Elementary School', state:'Sonsorol')
    
  end
end
