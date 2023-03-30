require 'roo'

$test_data = {}

def load_test_data(sheet_name)
  return $test_data[sheet_name] if $test_data.key?(sheet_name)

  workbook = Roo::Spreadsheet.open('test_data.xlsx')
  sheet = workbook.sheet(sheet_name)
  headers = sheet.row(1)
  test_data = []
  (2..sheet.last_row).each do |i|
    row = Hash[[headers, sheet.row(i)].transpose]
    test_data << row
  end

  $test_data[sheet_name] = test_data
  test_data
end




