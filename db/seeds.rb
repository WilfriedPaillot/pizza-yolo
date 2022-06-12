# Erase the content of all tables, hence reseting the related "id" counters
DatabaseCleaner.clean_with(:truncation)