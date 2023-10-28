#!/usr/bin/python3
"""
Gather data from an API
"""
import json
import requests
import sys


def user_dic(user_id):
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
                temp['username'] = username
                temp['task'] = task['title']
                temp['completed'] = task['completed']
                all_task.append(temp)
        return all_task


def main():
    all_users = {}
    for i in range(1, 11):
        all_users[i] = user_dic(i)
    with open("todo_all_employees.json", "w")as f:
        json.dump(all_users, f)


if __name__ == '__main__':
    main()
