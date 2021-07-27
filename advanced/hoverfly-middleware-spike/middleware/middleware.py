#!/opt/homebrew/bin/python3
import sys
import logging
import json

logging.basicConfig(filename='logs/middleware.log', level=logging.DEBUG)


def get_google_query(payload):
    return payload['headers']['google_query'][0]


def ask_google(google_query):
    import requests
    encoded_request = requests.utils.quote(
        'https://www.google.com/search?q=%s' % google_query)
    resp = requests.get(encoded_request)
    if resp.status_code == 200:
        return resp.text[0:100]
    return "No results"


def main():
    payload = sys.stdin.readlines()[0]

    logging.debug(payload)

    payload_dict = json.loads(payload)

    # getting requested city and date
    request_body = json.loads(payload_dict['request']['body'])
    google_query = get_google_query(payload_dict)
    logging.debug("Google query: %s" % google_query)

    google_response = ask_google(google_query)

    # some debugging info
    logging.debug("Google query: %s" % google_query)

    # adding json header
    payload_dict['response']['headers '] = {
        "Content-Type": ["application/json"]}

    if google_query == None:
        # checking whether origin and destination doesn't exceed 3 symbols
        payload_dict['response']['status'] = 400
        payload_dict['response']['body'] = '{"error": "no redirection header supplied"}'
        print(json.dumps(payload_dict))
        return

    # preparing response
    payload_dict['response']['status'] = 200
    payload_dict['response']['body'] = google_response

    # returning new payload
    print(json.dumps(payload_dict))


if __name__ == "__main__":
    main()
