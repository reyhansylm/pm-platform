import sys

def replace_word_in_file(file_path, old_word, new_word):
    try:
        with open(file_path, 'r') as file:
            content = file.read()
            replaced_content = content.replace(old_word, new_word)

        with open(file_path, 'w') as file:
            file.write(replaced_content)

        print("Word replaced successfully.")
    except FileNotFoundError:
        print("File not found.")
    except Exception as e:
        print("An error occurred:", str(e))

# Get command-line parameters
file_path = sys.argv[1]
old_word = sys.argv[2]
new_word = sys.argv[3]

# Perform word replacement
replace_word_in_file(file_path, old_word, new_word)