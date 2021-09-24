class ApplicationsController < ApplicationController

def index
  clause = ""
  if params[:search]
    clause = "c.first_name LIKE '%#{params[:search]}%' OR c.last_name LIKE '%#{params[:search]}%' OR c.email LIKE '%#{params[:search]}%'"
  end
  render :json => {
    total_applications: total_applications,
    qualifying_applications: qualifying_applications
  }
end

def total_applications(clause)
  sql = "SELECT COUNT(*) AS cnt FROM applications "
  if clause
    sql = "#{sql} WHERE #{clause}"
  end
  records = ActiveRecord::Base.connection.execute(sql)
  records.first[0]
end

def qualifying_applications(clause)
  sql = "SELECT * FROM credits INNER JOIN applications ON credits.client_id = applications.client_id WHERE credits.credit_score > 520 AND (applications.monthly_debt * 12) / applications.annual_income < .5"
  if clause
    sql = "#{sql} AND #{clause}"
  end
  records = ActiveRecord::Base.connection.execute(sql)
  records.to_a.size
end

end
