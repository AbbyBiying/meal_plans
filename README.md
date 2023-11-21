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
   -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMywiZXhwIjoxNzAxNzYzNzc3fQ.CAr4SCFAx4oYzyr5XQY7R9ton_p_PGl2onWv90shY0E" \
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

 
