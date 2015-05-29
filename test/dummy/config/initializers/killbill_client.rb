KillBillClient::API.net_http = {
  :verify_mode => OpenSSL::SSL::VERIFY_NONE
}

KillBillClient.url        = ENV['KILLBILL_SERVER']
KillBillClient.api_key    = ENV['KILLBILL_API_KEY']
KillBillClient.api_secret = ENV['KILLBILL_API_SECRET']
