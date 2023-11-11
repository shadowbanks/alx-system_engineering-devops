#!/usr/bin/python3
"""
Get all hot titles of a subreddit
"""
import requests


def recurse(subred, after=None, hot_list=[]):
    """
    Recursivily get all hot title
    """
    url = "https://www.reddit.com/r/" + subred + "/hot.json"
    headers = {"User-Agent": "Hot/1.0"}
    res = requests.get(url, headers=headers, params={"after": after})

    if res.status_code == 200:
        resq = res.json()
        data = resq["data"]
        after = data["after"]
        for title in data["children"]:
            hot_list.append(title["data"]["title"])
        if after:
            recurse(subred, after, hot_list)
        return hot_list
    else:
        return None
