class Authenticate
  include Interactor::Organizer

  organize Authenticate::PrepareAuthData, Authenticate::FindOrCreateUser, Authenticate::AddSocialUid
end
