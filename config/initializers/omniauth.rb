Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '168796073797243', '337c50acef385d4dadc73fcc3630d205', scope: 'email,user_birthday,read_stream', display: 'popup'
end