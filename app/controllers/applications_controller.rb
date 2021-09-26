class ApplicationsController < ApplicationController

def index
  clause = ""
  if params[:search].present?
    clause = "c.first_name LIKE '%#{params[:search]}%' OR c.last_name LIKE '%#{params[:search]}%' OR c.email LIKE '%#{params[:search]}%'"
  end
  render :json => {
    total_applications: total_applications(clause),
    qualifying_applications: qualifying_applications(clause)
  }
end

def total_applications(clause)
  sql = "SELECT COUNT(*) AS cnt FROM applications a INNER JOIN clients c ON a.client_id=c.id"
  if clause.present?
    sql = "#{sql} WHERE #{clause}"
  end
  #sql
  records = ActiveRecord::Base.connection.execute(sql)
  records.first[0]
end

def qualifying_applications(clause)
  sql = "SELECT * FROM credits cr INNER JOIN applications a ON cr.client_id = a.client_id INNER JOIN clients c ON cr.client_id=c.id WHERE cr.credit_score > 520 AND (a.monthly_debt * 12) / a.annual_income < .5"
  if clause.present?
    sql = "#{sql} AND (#{clause})"
  end
  records = ActiveRecord::Base.connection.execute(sql)
  records.to_a.size
end

end
