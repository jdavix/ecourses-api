class BaseSerializer
  include FastJsonapi::ObjectSerializer
  alias as_json serializable_hash
end
