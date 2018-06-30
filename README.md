# elastic-lifelog

## Prepare data to import into elastic search

### 1. Running logs (from RunKeeper)
#### Register application at runkeeper.com
First, Register the application at https://runkeeper.com/partner/applications. Then you can get the Client ID and Client Secret keys.  
Next, create a token for OAuth 2.0.

* Execute `runkeeper/runkeeper_auth.rb`
    * Acquire the access token interactively.

#### Create csv file for logstash
Save the acquired token as `runkeeper/data/token.yml` in the following format.

```yml
access_token: your access token
```

Create a runkeeper log csv file with the following command.
```sh
$> ruby runkeeper/runkeeper.rb
```

### 2. Step logs (from Fitbit)
#### Register application at dev.fitbit.com
First, register the application with dev.fitbit.com. Then you can get the key of the API.  
Next, open "OAuth 2.0 tutorial page" at https://dev.fitbit.com/apps/new (MANAGE MY APPS tab) and issue a token of OAuth 2.

* 1: Authorize
    * Select "Authorization Code Flow".
    * "Expires In (ms)" is set to 31536000. This is set valid for 1 year.
    * Other items can be default values.
    * Access the created URL and obtain "code".
* 1A Get Code
    * When you input "code" obtained on the screen, you can get the curl command and execute it.
        * Modify the created curl command and add `-d "expires_in=31536000"`.
        * Include this setting and set the expiration date of the token to 1 year.
    * You can get "Access token" and "Refresh token" by executing the curl command.
* 2: Parse response
    * When copying and pasting the json response obtained with "1A Get Code", you can get a token.

#### Create csv file for logstash
Save the acquired token as `fitbit/data/token.yml` in the following format.

```yml
client_id: your client id
client_secret: your client secret
access_token: your oauth2.0 access token
refresh_token: your oauth2.0 refresh token
```

Create a fitbit log csv file with the following command.
```sh
$> ruby fitbit/fitbit.rb
```

### 3. Weight logs (from Nokia Health(Withings))
#### Register application at developer.health.nokia.com

First, register the application with https://developer.health.nokia.com/partner/dashboard. Then you can get the key of the API.  
Next, open "Nokia Health API developer documentation" at https://developer.health.nokia.com/api and issue a token of OAuth 2.

* Step 1 : get a oAuth "request token"
    * Input your "Consumer key", "Consumer sercret", "Callback URL".
    * Click "Generate Request Token creation URL".
    * Open the generated URL.
* Step 2 : End-user authorization
    * Input two keys and click the "Generate link to present to the user".
    * Open the generated URL.
* Step 3 : Generating access token
    * Input your user id and click the "Generate Access Token creation URL".
    * Open the generated URL. 

Save the obtained four keys, "Consumer key", "Consumer secret", "Access token", "Access token secret", "User ID" in `withings/data/token.yml`.

```yml
key: your key
secret: your secret
access_token: your oauth1.0 access token
access_token_secret: your oauth1.0 access token secret
user_id: your user id
```

Create a withings log csv file with the following command.
```sh
$> ruby withings/withings.rb
```