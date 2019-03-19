class Authenticate
  include Interactor::Organizer

  organize Authenticate::FindOrCreateUser, Authenticate::AddSocialUid
end
