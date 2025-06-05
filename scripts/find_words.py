#!/usr/bin/env python3
import os
import sys

def search_files(search_terms):
    search_terms_lower = [term.lower() for term in search_terms]
    
    for root, dirs, files in os.walk('.'):
        if root.startswith('./.git') or root.startswith('./build'):
            continue
        for filename in files:
            filepath = os.path.join(root, filename)
            try:
                # Check file size
                if os.path.getsize(filepath) > 20 * 1024:  # 20kB
                    continue

                with open(filepath, 'r', errors='ignore') as file:
                    content = file.read().lower()
                    if all(term in content for term in search_terms_lower):
                        print(f"Found in {filepath}")
            except Exception: # pylint: disable=broad-except
                # Ignore errors like permission denied or file not found during os.walk
                continue

def main():
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} word1 [word2 ...]")
        sys.exit(1)
    
    search_terms = sys.argv[1:]
    search_files(search_terms)
    
if __name__ == "__main__":
    main()