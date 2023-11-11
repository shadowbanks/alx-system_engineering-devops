#!/usr/bin/python3
"""
Get all hot titles of a subreddit
"""
import requests


def count_words(subred, word_list, count=None, after=""):
    """
    Recursivily get all hot title
    """
    if count is None:
        count = {}
    url = "https://www.reddit.com/r/" + subred + "/hot.json"
    headers = {"User-Agent": "Count/1.0"}
    res = requests.get(url, headers=headers, params={"after": after})

    if res.status_code == 200:
        resq = res.json()["data"]
        after = resq["after"]
        for title in resq["children"]:
            titles = title["data"]["title"].split()
            for word in titles:
                word = word.lower()
                if word in word_list:
                    if word in count:
                        count[word] += 1
                    else:
                        count[word] = 1
        if after:
            return count_words(subred, word_list, count, after=after)
        else:
            # result = sorted(count.items(), key=lambda x: x[1], reverse=True)
            result = sorted(count.items(), key=lambda x: (-x[1], x[0]))

            for key, value in result:
                print(f"{key}: {value}")
            return
    else:
        return None
