local extensions = require('telescope').extensions
print(#extensions)
for i, v in ipairs(extensions) do
  print(i)
end
