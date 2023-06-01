#!/usr/bin/env python
import csv
import sys

def generate_insert_statements(csv_file, table_name, handler=print):
    with open(csv_file, 'r') as file:
        reader = csv.DictReader(file)
        headers = reader.fieldnames

        for row in reader:
            columns = ', '.join(headers)
            values = ', '.join([f"'{row[column]}'" for column in headers])
            insert_statement = f"INSERT INTO {table_name} ({columns}) VALUES ({values});"
            handler(insert_statement)

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <table_name> <csv_file>")
        sys.exit(1)

    table_name = sys.argv[1]
    csv_file = sys.argv[2]
    generate_insert_statements(csv_file, table_name)
