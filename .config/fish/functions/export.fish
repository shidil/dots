function dotenv
  for line in (cat .env)
        export $line
  end
end
