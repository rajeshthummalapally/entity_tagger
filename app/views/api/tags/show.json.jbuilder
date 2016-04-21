json.id @entity.id
json.name @entity.name
json.identifier @entity.identifier
json.tags @tags do |tag|
  json.tag_id tag.id
  json.tag_name tag.name
end
