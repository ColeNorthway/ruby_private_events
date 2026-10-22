### Overview

> You want to build a site similar to a private Eventbrite which allows users to create events and then manage user signups.
>>  + A user can create events.
>>  + A user can attend many events.
>>  + An event can be attended by many users.
>>  + Events take place at a specific date and at a location (which you can just store as a string, like “Andy’s House”).
> 
> This project will require you to model many-to-many relationships and also to be very conscious about your foreign keys and class names 
>>  + (hint: you won’t be able to just rely on Rails’ defaults like you have before).

### Steps
#### Setup
- [x] Think about and spec out how to set up your data models for this application.
- [x] Create a new private-events Rails app and GitHub repo. 
- [x] Update your README to be descriptive and link to this project.
#### Data
- [x] Create the database
- [x] List out migrations
- [x] Create our schema and review it
- [x] Fix user profile 'users_id'
- [x] Add validations for non-null and unique
- [x] Specify relationships in models
- [x] Add validates associated
- [x] Add event cleanup after user deletion to our models
#### Routing and Controllers
- [x] Create all routes
  - user (singleton)
    - new, create, edit, update, destroy
  - event
    - index, show, new, create, edit, update, destroy
  - session
    - new, create, destroy
- [x] Create all controllers
  - user
  - event
  - session
#### Users and Authentication
- [x] Add bcrypt to our gemfile and bundle install
- [x] Add password_digest to user
- [x] Add remember field to user
- [ ] Get signup (user#create)
- [ ] Get login (session#create)
- [ ] Get logout (session#destroy)
- [ ] Get edit profile (user#edit)
- [ ] Get delete profile (user#destroy)
- [ ] Get authorization
  - Pre-handlers
#### Edit User Profile Association
- [x] Make the association required in the user model
- [x] Add enum for the gender boolean
#### Event and User Controls
- [ ] Get our events index as the website root
- [ ] Get show for an event
- [ ] Get create for an event
- [ ] Get edit for an event
  - For the owner they can change properties
  - For another user they can join the event
- [ ] Get destroy for an event

### Models
+ User
  + Username - uniq - non-null
  + Email - uniq - non-null
  + Password - non-null
+ User Profile
  + City - non-null
  + State - non-null
  + Country - non-null
  + Gender
  + First Name - non-null
  + Last Name - non-null
+ Event
  + Name - uniq - non-null
  + Date - non-null
  + Location - non-null
  + References **user**
+ EventAttendance
  + Attendee_ID - non-null
  + Event_ID - non-null
  + References both **user** and **event**
  + Both are a *composite key* which means each *combo* is *unique*

### Model Creation
```bash
# First lets define our migrations from the cli

# Migrate user
#  - Password comes in later with digest
bin/rails generate model User username:string!:uniq email:string!:uniq

# User Profile
bin/rails generate model UserProfile city:string! state:string! country:string! gender:boolean first_name:string! last_name:string! users:references:uniq

# Migrate Event
bin/rails generate model Event name:string! date:date! location:string! users:references

# Migrate Event Attendance
#  - Create the model but edit the migration manually
bin/rails generate model EventAttendance event_id:integer! attendee_id:integer!
```

### Migration Creation
```ruby
# EventAttendance Migration (table creation)
class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :event_attendances, primary_key: [:event_id, :attendee_id] do |t|
      t.integer :event_id, null: false
      t.integer :attendee_id, null: false
    end
    
    add_foreign_key :event_attendances, :users, column: :attendee_id, primary_key: :id
    add_foreign_key :event_attendances, :events, column: :event_id, primary_key: :id
  end
end
```