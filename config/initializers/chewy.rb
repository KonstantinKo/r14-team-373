Chewy.configuration = {host: 'localhost:9200'} if Rails.env.development?
Chewy.configuration = {host: 'localhost:9200', prefix: 'test'} if Rails.env.test?
Chewy.configuration = {host: ENV['BONSAI_URL']} if Rails.env.production?
