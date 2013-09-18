#CHICKENS
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require "current_project_helpers"
require "faster_csv"
# require "csv-mapper"

BKGRND = "#FFFF66"
#EMAIL_SAMPLES = "mmoeyaert@nrdpfc.ca, mharnden@nrdpfc.ca, info@nrdpfc.ca, james@burrett.org"
 EMAIL_SAMPLES = "james@burrett.org"
 PROJECT_NUMBER = 66

MP = ["Unknown", "Boneless, Skinless Breast", "Boneless, Skinless Thigh"]
CO = ["Unknown", "Canada", "USA"]
ST = ["Unknown", "Bovain", "Cobb 500","Cobb 700","Cobb Mx","Erie","Hubbard","Hyline","Ross 308","Ross 344","Ross 708","Ross 744","Shaver","Shaver D"]
PR = ["Unknown", "Commercial", "Dam","Egg Layer","Sire"]
DG = ["Unknown", "Female", "Male"]
FE = ["Unknown", "Fast Feather", "Slow Feather"]
YN = ["Unknown", "Yes", "No"]

  def nice_date_display(the_date)
    return (the_date ? the_date.strftime('%Y.%m.%d') : '')
  end

class TrueClass
  def yesno
    "Yes"
  end
end

class FalseClass
  def yesno
    "No"
  end
end
class NilClass
  def yesno
    " "
  end
end

class ActiveRecord::Base
  def self.find_all_by_example(record, *attributes)
    conditions = Array.new
    query = Array.new
    for attribute in attributes.flatten.uniq
      query << "#{self.connection.quote_column_name(attribute.to_s)} = ?"
      conditions << record.send(attribute)
#      conditions << record[attribute]
    end
    self.find(:all, :conditions => [query.join(' AND ')] + conditions)
  end
end

class ApplicationController < ActionController::Base
   helper :all # include all helpers, all the time

#  # Pick a unique cookie name to distinguish our session data from others'
#  session :session_key => '_nrdpfc_session_id'
  include AuthenticatedSystem
#  include CurrentProjectHelper
#  include InPlaceEditing

  prepend_before_filter :login_required  
  
#  ActiveScaffold.set_defaults do |config|
#    config.security.current_user_method = :current_user
#    config.security.default_permission = false
#    config.actions.exclude :live_search
#    config.actions.add :search
#  end
  
  # This isn't working, I'm not quite sure why...
  # something isn't scoped right...

  def self.is_project_manager
    user = current_user
    return false if ! user
    return false if ! session[:project_id]
    project = Project.find_by_id(session[:project_id])
    return false if ! project
    @project_manager = (project.user_id == user.id)
  end

  def download_table
    # Horizontals use magic to define their tables so we have to use
    # reverse magic to figure it out
    table_name = self.class.respond_to?(:target_table_name) ?
                   self.class.target_table_name.to_s :
                   active_scaffold_config.model.table_name

    table = table_name.intern
    q = QueryBuilder.new(:parent => table, :tables => [ table ], :fields => { table => "*" })
    q.filter_by_project(current_project_id) unless (table == :projects)

    csv_string = FasterCSV.generate do |csv|
      csv << q.column_headers
      q.results.each {|result| csv << result }
    end

    send_data csv_string, :filename => "#{table_name}.csv"
  end

end
