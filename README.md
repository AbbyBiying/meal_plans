# Meal Planner API

Meal Planner is a Ruby on Rails API that empowers users to create personalized meal plans based on their dietary preferences. The app utilizes the ChatGPT API for generating meal recommendations and employs rate limiting with Rack::Attack to ensure fair API usage. Background job processing is handled by Resque, and Puma serves as the application server.

## Prerequisites

Make sure you have the following software installed on your system:

- Ruby 3.1.2p20
- Rails 7.1.2
- SQLite3
- Redis
- [Puma](https://github.com/puma/puma)
- [Ruby Redis Client](https://github.com/redis/redis-rb)
- [Resque](https://github.com/resque/resque)

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/AbbyBiying/meal_plans.git

2. Install dependencies:
   ```bash
   bundle install

3. Set up the database:
   ```bash
   rails db:create db:migrate

4. Start the server:
   ```bash
   rails server

## API Usage Examples
   ### create a new user
   ```bash
   curl -X POST \
   http://localhost:3000/signup \
   -H 'Content-Type: application/json' \
   -d '{
      "user": {
         "email": "sample_user_email@example.com",
         "password": "sample_password",
         "password_confirmation": "sample_password"
      }
   }'
   ```
   ### login
   ```bash
   curl -X POST \
   http://localhost:3000/login \
   -H 'Content-Type: application/json' \
   -H 'Accept: application/json' \
   -d '{"email": "sample46@example.com", "password": "dddsdfw3fFDS"}'
   ```

   ### set meal plans dietary preferences
   ```bash
   curl -X POST \
   http://localhost:3000/users/13/meal_plans \
   -H 'Content-Type: application/json' \
   -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
   -d '{
   "meal_plan": {
      "name": "Sample Meal Plan",
      "preferences": "Balanced",
      "goals": "Build Muscle",
      "allergies": "1000",
      "cuisines": "chinese",
      "amounts": "5"
   }
   }'

   ```
   
   ### only admin can see all users
   ```bash
   curl -X GET \
   http://localhost:3000/users \
   -H 'Content-Type: application/json' \
   -H 'Authorization: Bearer YOUR_ADMIN_ACCESS_TOKEN'



 
