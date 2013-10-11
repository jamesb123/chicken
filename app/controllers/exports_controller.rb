class ExportsController < ApplicationController

def index
    # send an email with xls attachment
    @mssg=''
    @indx = 0
    @err_flag = ''
    flash[:notice] = ""
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sample }
    end
    
end

def export
  
  batch_no = DateTime.now.strftime("%Y-%m-%d-%H-%M-%S")

  if request.post? && !params[:export_file].blank? 
    orig_fname = params[:export_file].original_filename
    ext_name = File.extname(orig_fname)
  else
    @err_flag = "error file missing"
    @mssg = "error file missing"
    render 'error'
    return
  end  
    
    if ext_name != ".xls"
      @err_flag = 'ERROR not XLS '
      @mssg = 'File Extension not .XLS ' + ext_name
      render 'error'
      return
    end
    
    email_subject = "XLS File for Project #{PROJECT_NUMBER}: " + " sent at " + batch_no + " by " + current_user.name 
    params[:export_file].open
    file_contents = params[:export_file].read
    
    Emailer.deliver_email_with_attachment(EMAIL_SAMPLES, email_subject, current_user.name, orig_fname, file_contents )
    @mssg = "Export successful. " + orig_fname
    #render 'show'
    #return

  
  end  
end
