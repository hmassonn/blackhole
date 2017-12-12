#!/usr/bin/env python
# -*- coding: utf-8 -*-

#	from mmazouz for have a new token
#	su.post('https://api.intra.42.fr/oauth/token')
#         .send({grant_type: 'refresh_token', client_id: client_id, client_secret: client-secret, refresh_token: refresh_token, redirect_uri: redirect})
#         .set('Content-Type', 'application/x-www-form-urlencoded')

import json
import requests


def getToken():
	data = {
	  'grant_type': 'client_credentials',
	  'client_id': '',
	  'client_secret': ''
	}
	r =  requests.post('https://api.intra.42.fr/oauth/token', data=data)
	token = json.loads(r.text)['access_token']
	return token

def get_all():
	finalier = []
	# finaler = []
	token = getToken()
	headers = {
	    'Authorization': 'Bearer '+token+'',
	}
	j = 0
	# num = 0;
	for i in range(100):
		r = requests.get('https://api.intra.42.fr/v2/users?filter[pool_year]=2016&campus_id=1&page='+str(i), headers=headers)
		if r.text == '[]':
			break
		final = json.loads(r.text)
		for info in final:
			finalier.append(info)
			print str(j) + "-->" + info['id']
			# q = requests.get('https://api.intra.42.fr/v2/users/'+ info['login'] + '/cursus_users', headers=headers)
			# if q.text != '[]':
			# 	trad = json.loads(q.text)
			# 	finaler.append(trad)
				# if len(trad) > 1:
				# 	print trad[0]['level']
				# if trad[0]['level'] > 8.18:
					# num += 1;
			j += 1
	# print 'le total est de :' + str(num)
	return finalier

def get_all_piscinard_petard():
	token = getToken()
	final = []
	headers = {
	    'Authorization': 'Bearer '+token+'',
	}
	with open("piscine.txt", "r") as f:
		tout = json.loads(f.read())
	for user in tout:
		print user['login']
		token = getToken()
		r = requests.get('https://api.intra.42.fr/v2/users/'+str(user["id"]), headers=headers)
		final.append(json.loads(r.text))
	return final

def work_on_piscinard_babar():
	with open("act.txt") as f:
		tout = json.loads(f.read())
	for user in tout:
		if user['pool_month'] != 'march':
			continue
		print user['login'] + " ---> " + str(user['cursus_users'][-1]['level']) + "----> " + str(user['location']).replace("None", "")
	print
	print
	for user in tout:
		if user['pool_month'] != 'march':
			continue
		if user['cursus_users'][-1]['level'] > 0:
			print user['login'] + "-->" + str(user['cursus_users'][-1]['level'])

def make_html_of_piscinard():
	with open("piscine.txt", "r") as f:
		tout = json.loads(f.read())
	final = ""
	for user in tout:
		final += '<img src="https://cdn.intra.42.fr/users/medium_'+user['login']+'.jpg" alt="'+user["login"]+'">\n'
	with open("/var/www/html/piscine.html", "w") as f:
		f.write(final)
if __name__ == "__main__":
	get_all()
#	with open("act.txt", "w") as f:
		# f.write(json.dumps(get_all_piscinard_petard()))
	# work_on_piscinard_babar()
	#make_html_of_piscinard()
