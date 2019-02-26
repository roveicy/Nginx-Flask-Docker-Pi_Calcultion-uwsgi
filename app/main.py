from flask import Flask

app = Flask(__name__)

def calc_pi(limit):  # Generator function
    """
    Prints out the digits of PI
    until it reaches the given limit
    """

    q, r, t, k, n, l = 1, 0, 1, 1, 3, 3

    decimal = limit
    counter = 0
    digits = []

    while counter != decimal + 1:
        if 4 * q + r - t < n * t:
            digits.append(n)
            if decimal == counter:
                break
            counter += 1
            nr = 10 * (r - n * t)
            n = ((10 * (3 * q + r)) // t) - 10 * n
            q *= 10
            r = nr
        else:
            nr = (2 * q + r) * l
            nn = (q * (7 * k) + 2 + (r * l)) // (t * l)
            q *= k
            t *= l
            l += 2
            k += 1
            n = nn
            r = nr
    return digits

def pi_tostr(digits):
    ss = []
    for i, d in enumerate(digits):
        ss.append(str(d))
        if i == 0:
            ss.append(".")
        if i % 10 == 2:
            ss.append("\n")

    return "".join(ss)

@app.route("/")
def access_pi_102():
    s = pi_tostr(calc_pi(102))
        
    return s

@app.route("/<digits>")
def access_pi(digits):
    limit = int(digits)
    if limit < 0:
        limit = 0
    s = pi_tostr(calc_pi(limit+2))
    return s

if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host="0.0.0.0", debug=False, port=80)
