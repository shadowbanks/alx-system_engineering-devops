#!/usr/bin/python3
"""
Gather data from an API
"""
import json
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
        todos = res_todos.json()
        all_task = []
        for task in todos:
            if (task['userId'] == user_id):
                temp = {}
                temp['task'] = task['title']
                temp['completed'] = task['completed']
                temp['username'] = username
                all_task.append(temp)
        with open(f"{user_id}.json", "w")as f:
            json.dump({user_id: all_task}, f)


if __name__ == '__main__':
    main()
