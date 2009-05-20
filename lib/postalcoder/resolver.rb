module PostalCoder
  class Resolver < Persistence::DataStore

    def resolve(postal_code_value, format_symbol = nil)
      postal_code = Formats.instantiate(postal_code_value, format_symbol)
      fetch(postal_code.to_s) do |code|
        GeocodingAPI::Query.get(code)
      end
    end

  end
end