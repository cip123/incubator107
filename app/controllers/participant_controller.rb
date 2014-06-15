class ParticipantController < SubdomainController

  def verify 
    crypt = ActiveSupport::MessageEncryptor.new(Rails.configuration.secret_key_base)
    decrypted_data = crypt.decrypt_and_verify(params[:token])
    participant = Participant.find(decrypted_data)
    if !participant.verified?
      participant.verified = true
      send_pending_mail(participant)
    end
    participant.save
  end


    private
    def send_pending_mail (participant) 
      workshop_participant = WorkshopParticipant.find_by_participant_id(participant.id) 
      if workshop_participant
        ParticipantMailer.welcome_mail(participant, workshop_participant.workshop_id).deliver
      end
  end
end
