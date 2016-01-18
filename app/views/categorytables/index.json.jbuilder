json.array!(@categorytables) do |categorytable|
  json.extract! categorytable, :id, :name, :system, :owner, :user_id, :rank
  json.url categorytable_url(categorytable, format: :json)
end
