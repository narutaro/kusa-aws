require 'json'
require 'aws-sdk-dynamodb'

def add_project(table, body)
  table.put_item({ item: body })  
end

def delete_project(table, body)
  params = { table_name: table, key: { 'project-id': body['project-id'] } }
  begin
    table.delete_item(params)
  rescue Aws::DynamoDB::Errors::ServiceError => error
    puts error.message
  end
end

def update_project(table, body)
  params = {
    table_name: table,
    key: { 'project-id': event['project-id'] },
    attribute_updates: {
      put: {
        value: { name: event['name'] },
        action: "PUT"
      }
    }
  }
  table.update_item(params)  
end

def list_project(table)
  scan_output = table.scan({ limit: 50, select: "ALL_ATTRIBUTES" })

  scan_output.items.each do |item|
    keys = item.keys
    keys.each do |k|
      puts "#{k}: #{item[k]}"
    end
  end
end

def lambda_handler(event:, context:)
  
  http_method = event['httpMethod']
  body = JSON.parse(event['body'])
  
  dynamodb = Aws::DynamoDB::Resource.new(region: 'us-east-2')
  table = dynamodb.table('project')
  
  #puts context.inspect
  #puts event
  #p event.project-id
  #p event['project-id']
  puts "http_method: #{http_method}"
  puts "event_body: #{event['body']}"
  puts "event_body_project_id: #{event['body']['project-id']}"
  
  case http_method
    when 'GET'    then list_project(table)
    when 'PUT'    then update_project(table, body)
    when 'POST'   then add_project(table, body)
    when 'DELETE' then delete_project(table, body)
    else 0
  end

  puts JSON.generate(event)
  #p list_project(table).class
  
  #{ statusCode: 200, body: list_project(table) }
  #{ statusCode: 200, body: JSON.generate(event) }
  { statusCode: 200, body: JSON.generate(list_project(table)) }

end
