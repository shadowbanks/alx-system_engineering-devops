#!/usr/bin/python3
""" Get the hot posts of a subreddit"""
import requests


def top_ten(subreddit):
    """Get the top 10 posts"""
    url = "https://www.reddit.com/r/" + subreddit + "/top.json"
    headers = {"User-Agent": "TopHotPost/1.0 {by Wills}"}
    res = requests.get(url, headers=headers)
    if (res.status_code == 200):
        data = res.json()["data"]
        data = data["children"][:10]
        for post in data:
            print(post["data"]["title"])
        return
    print("None")
