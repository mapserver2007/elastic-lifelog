# elastic-lifelog

## runkeeper log
### Register application at runkeeper.com
First, Register the application at https://runkeeper.com/partner/applications. Then you can get the Client ID and Client Secret keys.  
Next, create a token for OAuth 2.0.

* Execute `runkeeper/runkeeper_auth.rb`
    * Acquire the access token interactively.

### Create csv file for logstash
Create a fitbit log csv file with the following command. At this time, use OAuth2 token.
```sh
$> ruby runkeeper/runkeeper.rb -t %ACCESS_TOKEN% -n (number of logs)
```

## fitbit log
### Register application at dev.fitbit.com
First, register the application with dev.fitbit.com. Then you can get the key of the API.  
Next, open "OAuth 2.0 tutorial page" at https://dev.fitbit.com/apps/new (MANAGE MY APPS tab) and issue a token of OAuth 2.

* 1: Authorize
    * Select "Authorization Code Flow".
    * ""Expires In (ms)" is set to 31536000. This is set valid for 1 year.
    * Other items can be default values.
    * Access the created URL and obtain "code".
* 1A Get Code
    * When you input "code" obtained on the screen, you can get the curl command and execute it.
        * Modify the created curl command and add `-d "expires_in=31536000"`.
        * Include this setting and set the expiration date of the token to 1 year.
    * You can get "Access token" and "Refresh token" by executing the curl command.
* 2: Parse response
    * When copying and pasting the json response obtained with "1A Get Code", you can get a token.

### Create csv file for logstash
Create a fitbit log csv file with the following command. At this time, use OAuth2 token.
```sh
$> ruby fitbit/fitbit.rb -i %USER_ID% -s %CLIENT_SECRET% -t %ACCESS_TOKEN% -r %REFRESH_TOKEN%
```

