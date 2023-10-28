#!/usr/bin/python3
"""
Gather data from an API
"""
import csv
import requests
import sys


def main():
    user_id = int(sys.argv[1])
    url_todos = "https://jsonplaceholder.typicode.com/todos"
    url_user = "https://jsonplaceholder.typicode.com/users" + f'/{user_id}'
    res_todos = requests.get(url_todos)
    res_user = requests.get(url_user)

    if (res_user.status_code == 200):
        user = res_user.json()
        username = user['username']
        user = user['name']
        todos = res_todos.json()

        with open(f"{user_id}.csv", "w") as f:
            fnames = ['user_id', 'username', 'completed', 'title']
            write = csv.DictWriter(f, fieldnames=fnames, quoting=csv.QUOTE_ALL)
            for task in todos:
                if (task['userId'] == user_id):
                    write.writerow({
                        'user_id': str(user_id),
                        'username': str(username),
                        'completed': str(task['completed']),
                        'title': str(task['title'])
                        })


if __name__ == '__main__':
    main()
