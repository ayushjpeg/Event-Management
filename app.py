import sqlite3
import datetime
from flask import Flask, request, jsonify, render_template, redirect, url_for
from random import randint

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def renderLoginPage():
    return render_template('index.html')


@app.route('/ticket', methods=['GET', 'POST'])
def ticekt_generation():
    return render_template('ticket.html')

@app.route('/registration', methods=['GET','POST'])
def Registration_func():
    events = runQuery("SELECT * FROM events")

    if request.method == 'POST':
        Name = request.form['FirstName'] + " " + request.form['LastName']
        Mobile = request.form['MobileNumber']
        Event = request.form['Event']
        Email = request.form['Email']

        if len(Mobile) != 10:
            return render_template('loginfail.html', errors=["Invalid Mobile Number!"])

        if Email[-4:] != '.com':
            return render_template('loginfail.html', errors=["Invalid Email!"])

        if len(runQuery("SELECT * FROM participants WHERE event_id=? AND mobile=?", (Event, Mobile))) > 0:
            return render_template('loginfail.html', errors=["Student already Registered for the Event!"])

        if runQuery("SELECT COUNT(*) FROM participants WHERE event_id=?", (Event,))[0][0] >= runQuery("SELECT participants FROM events WHERE event_id=?", (Event,))[0][0]:
            return render_template('loginfail.html', errors=["Participants count fulfilled Already!"])

        runQuery("INSERT INTO participants(event_id, fullname, email, mobile, college) VALUES (?, ?, ?, ?, 'COEP')", (Event, Name, Email, Mobile))

        return render_template('registration.html', events=events, errors=["Successfully Registered!"])
    return render_template('registration.html', events=events)

@app.route('/loginfail', methods=['GET'])
def renderLoginFail():
    return render_template('loginfail.html')

@app.route('/admin', methods=['GET', 'POST'])
def renderAdmin():
    if request.method == 'POST':
        UN = request.form['username']
        PS = request.form['password']

        cred = runQuery("SELECT * FROM admin")
        print(cred)
        for user in cred:
            if UN == user[0] and PS == user[1]:
                return redirect('/eventType')

        return render_template('admin.html', errors=["Wrong Username/Password"])

    return render_template('admin.html')

@app.route('/eventType', methods=['GET', 'POST'])
def getEvents():
    eventTypes = runQuery("SELECT *,(SELECT COUNT(*) FROM participants AS P WHERE T.type_id IN (SELECT type_id FROM events AS E WHERE E.event_id = P.event_id ) ) AS COUNT FROM event_type AS T;")

    events = runQuery("SELECT event_id, event_title, (SELECT COUNT(*) FROM participants AS P WHERE P.event_id = E.event_id ) AS count FROM events AS E;")

    types = runQuery("SELECT * FROM event_type;")

    venue = runQuery("SELECT * FROM venue")

    if request.method == "POST":
        try:
            Name = request.form["newEvent"]
            fee = request.form["Fee"]
            participants = request.form["maxP"]
            Type = request.form["EventType"]
            venue = request.form["Eventvenue"]
            Date = request.form['Date']
            runQuery("INSERT INTO events(event_title, event_price, participants, type_id, venue_id, date) VALUES (?, ?, ?, ?, ?, ?)", (Name, fee, participants, Type, venue, Date))
        except:
            EventId = request.form["EventId"]
            runQuery("DELETE FROM events WHERE event_id=?", (EventId,))

    return render_template('events.html', events=events, eventTypes=eventTypes, types=types, venues=venue)

@app.route('/eventinfo')
def rendereventinfo():
    events = runQuery("SELECT *,(SELECT COUNT(*) FROM participants AS P WHERE P.event_id = E.event_id ) AS count FROM events AS E LEFT JOIN event_type USING(type_id) LEFT JOIN venue USING(venue_id);")
    return render_template('events_info.html', events=events)

@app.route('/participants', methods=['GET', 'POST'])
def renderParticipants():
    events = runQuery("SELECT * FROM events;")
    if request.method == "POST":
        Event = request.form['Event']
        participants = runQuery("SELECT p_id, fullname, mobile, email FROM participants WHERE event_id=?", (Event,))
        return render_template('participants.html', events=events, participants=participants)

    return render_template('participants.html', events=events)

def runQuery(query, params=()):
    try:
        conn = sqlite3.connect('event_details.db')
        cursor = conn.cursor()
        cursor.execute(query, params)
        conn.commit()
        res = cursor.fetchall()
        conn.close()
        return res
    except Exception as e:
        print(e)
        return []

if __name__ == "__main__":
    app.run(debug=True,port=8000)
