json.array!(@selects) do |select|
  json.extract! select, :id, :question_id, :desc, :active_flg, :delete_flg
  json.url select_url(select, format: :json)
end
