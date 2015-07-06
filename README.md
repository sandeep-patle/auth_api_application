# API Application

This application providing REST API to CRUD user and user session management.

To improve db performance we used sharding, devided users table into part. Also set indexs for tables.

Here we are validating api call by authorization token. When user login generating authorization token this token need to pass in header for all subsquent secure api call.

On logout we are destroying this authorization token. Using client id to diffrentiate api call from different sources. Means if you are logged in from web application and android app then both will use different token.

To generate auth token we are using SecureRandom ruby class

Encrypt and decrypt password using Digest::SHA2 ruby class.

## Example


Given the following models:

```API's
Create user - POST # http://localhost:3000/api/v1/users

Headers:
{
	client_id => unique id of your application
}

Payload: 
{
	user[email] => 'spatlemail@gmail.com',
	user[password] => '123456',
	user_detail[first_name] => 'sandeep',
	user_detail[last_name] => 'patle',
	user_detail[mobile_number] => 748596321
}

Response:
Return 200 status if user created or else 400 bad request

------------------------------------------------------------
For login -

Create session - POST # http://localhost:3000/api/v1/sessions
Headers:
{
	client_id => unique id of your application
}

Payload: 
{
	session[email] => 'spatlemail@gmail.com',
	session[password] => '123456'
}

Response:
On success return user id and auth token

---------------------------------------------------------------
Get user details -

Find user - Get # http://localhost:3000/api/v1/users/#{id}

Headers:
{
	client_id => unique id of your application,
	auth_token => [auth_token]
}

Response:

On success return user data
{
	id: 2
	email: "spatlemail@gmail.com"
	info: {
		created_at: "2015-07-05T13:10:32Z"
		first_name: "sandeep"
		id: 1
		last_name: "patle"
		mobile_number: "852963741"
		updated_at: "2015-07-05T13:10:32Z"
		user_id: 2
	}-
}

Unauthorize request(401) if auth token not valid
----------------------------------------------------------
Destroy session

Delete # http://localhost:3000/api/v1/sessions/#{id}

Headers:
{
	client_id => unique id of your application,
	auth_token => [auth_token]
}

Response:
Success status(200) if session delete

Unauthorize request(401) if auth token not valid

```

## Setup

1. Clone the repository
2. Bundle install
3. rake db:create
4. rake db:migrate

## Environment
Ruby - 1.9.3
Rails - 3.2.12
Database - PostgreSQL

## Scaling PostgreSQL Performance Using Table Partitioning
Table partitioning is a good solution for large database and slow query . We can take users table and split it into many smaller tables - these smaller tables are called partitions or child tables. Operations such as backups, SELECTs, and DELETEs can be performed against individual partitions or against all of the partitions. Partitions can also be dropped or exported as a single transaction requiring minimal logging.
