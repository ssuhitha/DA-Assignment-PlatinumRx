def remove_duplicates(s):
    """Remove duplicate characters from a string using a loop."""
    result = ""
    for char in s:
        if char not in result:
            result += char
    return result

# Test cases
test_strings = ["programming", "aabbcc", "hello world", "mississippi", "abcabc"]
for s in test_strings:
    print(f'"{s}" → "{remove_duplicates(s)}"')
