#!/usr/bin/python3
"""
Gather data from an API
"""
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
        user = user['name']
        todos = res_todos.json()
        total = 0
        done = 0
        done_task = []
        for task in todos:
            if (task['userId'] == user_id):
                total += 1
                if (task['completed']):
                    done += 1
                    done_task.append(task['title'])
        print(f"Employee {user} is done with tasks({done}/{total}):")
        for task in done_task:
            print(f"\t {task}")


if __name__ == '__main__':
    main()
