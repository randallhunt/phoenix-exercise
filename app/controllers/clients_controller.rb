class ClientsController < ApplicationController

def index
  clause = ''
  if params[:search].present?
    clause = "c.first_name LIKE '%#{params[:search]}%' OR c.last_name LIKE '%#{params[:search]}%' OR c.email LIKE '%#{params[:search]}%'"
  end

  #render :json => { clause: clause }

  render :json => {
    total_clients: total_clients(clause),
    clients_with_application: clients_with_application(clause),
    clients_missing_data: clients_missing_data(clause),
    average_credit_score: average_credit_score(clause)
  }
end

def total_clients(clause)
  sql = "SELECT COUNT(*) AS cnt FROM clients c"
  if clause.present?
    sql = "#{sql} WHERE #{clause}"
  end
  records = ActiveRecord::Base.connection.execute(sql)
  records.first[0]
end

def clients_with_application(clause)
  sql = %Q(
    SELECT DISTINCT(a.client_id) AS cnt 
    FROM applications a
    INNER JOIN clients c ON a.client_id=c.id
  )
  if clause.present?
    sql = "#{sql} WHERE #{clause}"
  end
  records = ActiveRecord::Base.connection.execute(sql)
  records.to_a.size
end

def clients_missing_data(clause)
  sql = %Q(
    SELECT c.first_name,  c.last_name, c.email, r.credit_score
    FROM clients c
    LEFT JOIN credits r on c.id=r.client_id
    WHERE r.client_id IS NULL
  )
  if clause.present?
    sql = "#{sql} AND (#{clause})"
  end
  records = ActiveRecord::Base.connection.execute(sql)
  records.to_a.size
end

def average_credit_score(clause)
  sql = %Q(
    SELECT AVG(r.credit_score) AS avg
    FROM credits r
    INNER JOIN clients c ON c.id=r.client_id
  )
  if clause.present?
    sql = "#{sql} WHERE (#{clause})"
  end
  records = ActiveRecord::Base.connection.execute(sql)
  records.first[0]
end

end
