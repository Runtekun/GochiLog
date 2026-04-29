module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # WebSocket接続時にログインユーザーを識別する
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    # Deviseのセッションからログインユーザーを取得し、未ログインは接続を拒否する
    def find_verified_user
      if (verified_user = env["warden"].user)
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
