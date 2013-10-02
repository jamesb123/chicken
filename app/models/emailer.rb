class Emailer < ActionMailer::Base
#--- email sent to new user account (login) 
  def contact(recipient, subject, name, login, password, sent_at = Time.now)
      @subject = subject
      @recipients = recipient
      @from = 'info@nrdpfc.ca'
      @reply_to = "vsrithayakumar@nrdpfc.ca"
      @sent_on = sent_at
      @body["name"] = name
      @body["email"] = recipient
      @body["login"] = login
      @body["password"] = password
      @headers = {content_type => 'text/html'}
   end

 #- email sent to batch submission with attachment ------------------------------
  def email_with_attachment(recipient_a, subject_a, user_a, org_fname, file_attach)
      @recipients = recipient_a
      @subject = subject_a
      @from =   "info@nrdpfc.ca"
      @reply_to = "vsrithayakumar@nrdpfc.ca"
      @body = subject_a  
      part :content_type => "multipart/mixed" do |p|
      p.attachment :content_type => "csv/text", 
#      :body => File.open("public/whale_batch.csv", "rb") { |f| f.read },
      :body => file_attach,
      :filename => org_fname,
      :transfer_encoding => "base64",
      :charset => "utf-8"
      end    
  end
  # email sent to single sample submission --------------------------------------
  def submission(recipient, subject, collected_by, project_id, date_collected, sent_at = Time.now)
      @subject = subject 
      @recipients = recipient
      @from = 'info@nrdpfc.ca'
      @reply_to ='vsrithayakumar@nrdpfc.ca'
      @sent_on = sent_at
      @body = "Road Runner Sample - Project " + project_id + " collected by " + collected_by + " on " + date_collected
      @headers = {content_type => 'text/html'}
   end


  def welcome_message(sent_at = Time.now) 
    @subject    = 'Customer Mailer#welcome_message' 
    @body       = {}
    @recipients = '' 
    @from       = '' 
    @sent_on    = sent_at 
    @headers    = {} 
    @body["email"] = '' 
  end   
end