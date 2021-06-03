import 'dart:io';
import 'package:diapason/models/claim.dart';
import 'package:diapason/models/event.dart';
import 'package:diapason/models/item.dart';
import 'package:diapason/models/leader.dart';
import 'package:diapason/models/member.dart';
import 'package:diapason/models/story.dart';
import 'package:diapason/notifier/claim_notifier.dart';
import 'package:diapason/notifier/event_notifier.dart';
import 'package:diapason/notifier/item_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/notifier/story_notifier.dart';
import 'package:diapason/notifier/visitor_notifier.dart';
import 'package:diapason/views/my_material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diapason/models/activity.dart';
import 'package:diapason/notifier/activity_notifier.dart';
import 'package:diapason/notifier/user_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diapason/models/auth_user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class DiapasonApi {

  // PROPERTIES : INSTANCES
  final _auth = FirebaseAuth.instance; // Instance de l'authentificateur
  static final _firestore = FirebaseFirestore.instance; // Instance de la BDD cloud firestore
  static final _firestorage = FirebaseStorage.instance.ref(); // Instance du storage firebase

  // Firebase shortcuts
  final fireMember = _firestore.collection(keyMembers);
  final fireEvent = _firestore.collection(keyEvents);
  final fireStory = _firestore.collection(keyStories);
  final fireActivity = _firestore.collection(keyActivities);
  final fireItem = _firestore.collection(keyItems);

  // WARNING : BACK-END FUNCTIONS

  Future<void>insertNewFieldInUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(keyMembers).get();
      List<dynamic> emptyList = [];
      snapshot.docs.forEach((document) async {
        Member member = Member.fromMap(document.data());
        await _firestore.collection(keyMembers).doc(member.uid).update({keyItems: emptyList}); // BDD action
      });
      print('OK');
    } catch(error) {
      print('KO');
      return error;
    }
  }


  Future<void>insertNewFieldInUser(MemberNotifier memberNotifier) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection(keyMembers).doc(memberNotifier.currentMember.uid).get();
      List<dynamic> emptyList = [];
      if(snapshot != null) {
        Member member = Member.fromMap(snapshot.data());
        await _firestore.collection(keyMembers).doc(member.uid).update({keyItems: emptyList}); // BDD action
      }
      print('OK');
    } catch(error) {
      print('KO');
      return error;
    }
  }



  // USERS

  // Get current User
  initializeCurrentUser(UserNotifier userNotifier) async {
    User firebaseUser = await _auth.currentUser;
    if(firebaseUser != null) {
      userNotifier.currentUser = firebaseUser;
      // userNotifier.setUser(firebaseUser);
    }
  }

  // Log existing members
  login(AuthUser authUser, UserNotifier userNotifier) async {
    UserCredential authResult = await _auth.signInWithEmailAndPassword(email: authUser.email, password: authUser.password)
        .catchError((error) => print(error.code));
    if(authResult != null) {
      User firebaseUser = authResult.user;
      if(firebaseUser != null) {
        // print('Log In: $firebaseUser');
        userNotifier.currentUser = firebaseUser;
      }
    }
  }

  // Sending a password reset request
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Sign out connected user
  Future<void>signOut (UserNotifier userNotifier) async {
    await _auth.signOut().catchError((error) => print(error.code));
    userNotifier.currentUser = null;
  }

  // MEMBERS

  createMember(String uid, Map map) { // Add the user to the members collection
    fireMember.doc(uid).set(map);
  }

  addMemberFromAccountCreation(User user) {
    String uid = user.uid;
    String name = 'Diapason';
    String forename = 'Utilisateur';
    String imageUrl = '';
    String implication = '🔍 Visiteur';
    String address = 'Non renseignée';
    String phone = 'Non renseigné';
    String mail = user.email;
    bool admin = false;
    bool membership = false;
    List<dynamic> clubs = [];
    List<dynamic> events = [];
    List<dynamic> blackList = [];
    List<dynamic> items = [];
    bool superAdmin = false;
    Map<String, dynamic> map = {
      keyUid: uid,
      keyName : name,
      keyForename: forename,
      keyAddress: address,
      keyImplication: implication,
      keyAdmin: admin,
      keyMembership: membership,
      keyImageUrl: imageUrl,
      keyClubs: clubs,
      keyEvents: events,
      keyPhone: phone,
      keyItems: items,
      keyMail: mail,
      keyBlackList: blackList,
      keySuperAdmin: superAdmin,
    };
    createMember(uid,map);
  }

  getMe(UserNotifier userNotifier, MemberNotifier memberNotifier) async {
    try{
      DocumentSnapshot snapshot = await _firestore.collection(keyMembers).doc(userNotifier.currentUser.uid).get();
      Member _currentMember;
      if(snapshot != null) {
        Map<String, dynamic> data = snapshot.data();
        data[keyRef] = snapshot.reference; // To keep doc reference for further action
        _currentMember = Member.fromMap(data);
        memberNotifier.currentMember = _currentMember; // Client action
        // print('Get current member succeed in api');
      }
    } catch (error) {
      // print('Get current member failed in Api');
      return error;
    }
  }

  Future<void>getMembersAdmin(MemberNotifier memberNotifier) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(keyMembers).where(keyAdmin, isEqualTo: true).get();
      List<Member> _membersAdminList = [];
      snapshot.docs.forEach((document) {
        Member member = Member.fromMap(document.data());
        _membersAdminList.add(member);
      });
      memberNotifier.membersAdminList = _membersAdminList; // Client action
      // print('Get admins list succeed in api');
    } catch(error) {
      // print('Get admins list failed in api');
    }
  }

  Future<void>getMembersShip(MemberNotifier memberNotifier) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(keyMembers).where(keyMembership, isEqualTo: true).get();
      List<Member> _membersShipList = [];
      if(snapshot != null) {
        snapshot.docs.forEach((document) {
          Member member;
          Map<String, dynamic> data = document.data();
          member = Member.fromMap(data);
          if (member.forename != 'Utilisateur' && member.name != 'Diapason') {
            _membersShipList.add(member);
          }
        });
        memberNotifier.membersShipList = _membersShipList; // Client action
      }
      // print('Get membership members succeed in api');
    } catch (error) {
      // print('Get membership members failed in api');
      return error;
    }
  }



  Future<void>blackListMember(MemberNotifier memberNotifier, String blackListedMemberUid) async {
    try {
      if(!memberNotifier.currentMember.blackList.contains(blackListedMemberUid)) {
        await _firestore.collection(keyMembers).doc(memberNotifier.currentMember.uid).update({keyBlackList: FieldValue.arrayUnion([blackListedMemberUid])}); // BDD action
        memberNotifier.addBlackUidToCurrentMember(blackListedMemberUid); // Client side action
        DocumentSnapshot snapshot = await _firestore.collection(keyMembers).doc(blackListedMemberUid).get();
        Member _blackListedMember;
        if(snapshot != null) {
          Map<String, dynamic> data = snapshot.data();
          _blackListedMember = Member.fromMap(data);
          memberNotifier.addMemberToBlackList(_blackListedMember); // Client side action
          // print('Black listed member added in Current Member Black list succeed in api');
        }
      } else {
        return null;
      }
    } catch(error) {
      // print('Set member in current member black list failed in api');
      return error;
    }
  }

  Future<void>clearBlackListedMember(MemberNotifier memberNotifier, String blackListedUidToClear) async {
    try {
      if(memberNotifier.currentMember.blackList.contains(blackListedUidToClear)) {
       await _firestore.collection(keyMembers).doc(memberNotifier.currentMember.uid).update({keyBlackList: FieldValue.arrayRemove([blackListedUidToClear])}); // BDD action
       memberNotifier.clearBlackUidInCurrentMember(blackListedUidToClear); // Client side action
       DocumentSnapshot snapshot = await _firestore.collection(keyMembers).doc(blackListedUidToClear).get();
       Member _blackListedMemberToClear;
       if(snapshot != null) {
         Map<String, dynamic> data = snapshot.data();
         _blackListedMemberToClear = Member.fromMap(data);
         memberNotifier.deleteMemberInBlackList(_blackListedMemberToClear); // Client side action
         // print('Black listed member deleted in Current Member Black list succeed in api');
       }
      } else {
        return null;
      }
      // print('Clear black listed member succeed in api');
    } catch (error) {
      // print('Clear black listed member failed in api');
    }
  }


  Future<void>getCurrentUserBlackListedMembers(MemberNotifier memberNotifier) async {
    try {
      if(memberNotifier.currentMember.blackList.isNotEmpty) {
        List<Member> _blackListedMembers = [];
        for(String memberId in memberNotifier.currentMember.blackList) {
          DocumentSnapshot snapshot = await _firestore.collection(keyMembers).doc(memberId).get();
          Member _currentMember;
          if(snapshot != null) {
            Map<String, dynamic> data = snapshot.data();
            _currentMember = Member.fromMap(data);
            _blackListedMembers.add(_currentMember);
          }
        }
        memberNotifier.membersBlackList = _blackListedMembers;
        // print('Get current User black listed members succeed in api');
      }
    } catch (error) {
      // print('Get current User black listed members failed in api');
      return error;
    }
  }

  void updateMember(Member member, Map<String, dynamic> data) {
    _firestore.collection(keyMembers).doc(member.uid).update(data);
  }

  Future<void>uploadMember(MemberNotifier memberNotifier, Member member, File image) async {
    try {
      Member _updatedMember;
      Map<String, dynamic> map = {
        keyUid: member.uid,
        keyName: member.name,
        keyForename: member.forename,
        keyAddress: member.address,
        keyImplication: member.implication,
        keyAdmin: member.admin,
        keyMembership: member.membership,
        keyClubs: member.clubs,
        keyEvents: member.events,
        keyItems: member.items,
        keyPhone: member.phone,
        keyMail: member.mail,
        keyBlackList: member.blackList,
        keySuperAdmin: member.superAdmin,
      };
      if (image != null) {
        Reference ref = storageMember.child(member.uid);
        String imageUrl = await addImage(image, ref);
        map[keyImageUrl] = imageUrl;
      } else {
        map[keyImageUrl] = member.imageUrl;
      }
      _updatedMember = Member.fromMap(map);
      updateMember(member, map); // BDD action
      memberNotifier.currentMember = _updatedMember; // Client action
    } catch(error) {
      print(error);
      return error;
    }
  }

  // VISITORS

  Future<void>getVisitors(VisitorNotifier visitorNotifier) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(keyMembers).where(keyMembership, isEqualTo: false).get();
      List<Member> _visitorsList = [];
      snapshot.docs.forEach((document) {
        Member member = Member.fromMap(document.data());
        _visitorsList.add(member);
      });
      visitorNotifier.visitorsList = _visitorsList;
      // print('Get membership members succeed in api');
    } catch (error) {
      // print('Get membership members failed in api');
      return error;
    }
  }

  Future<void>upgradeVisitor(VisitorNotifier visitorNotifier, Member visitor) async {
    Map<String, dynamic> data = {};
    data = visitor.toMap();
    data[keyMembership] = true;
    Member _updatedMember;
    _updatedMember = Member.fromMap(data);
    updateMember(_updatedMember, data); // BDD action
    visitorNotifier.upgradeVisitorToMember(visitor); // Client action


  }

  // CLAIMS

  Future<void>getClaims(ClaimNotifier claimNotifier) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(keyClaims).orderBy(keyDate, descending: true).get();
      List<Claim> _claimList = [];
      snapshot.docs.forEach((document) {
        Claim claim = Claim.fromMap(document.data());
        _claimList.add(claim);
      });
      claimNotifier.claimList = _claimList;
      // print('Get claims succeed in api');
    } catch(error) {
      // print('Get claims failed in api');
    }
  }

  Future<void>uploadClaim(ClaimNotifier claimNotifier, Claim submittedClaim) async {
    try {
      DocumentReference documentReference = _firestore.collection(keyClaims).doc();
      Map<String, dynamic> map = {
        keyCid: documentReference.id,
        keyContent: submittedClaim.content,
        keyType: submittedClaim.type,
        keyIsHate: submittedClaim.isHate,
        keyIsSexual: submittedClaim.isSexual,
        keyIsDelusive: submittedClaim.isDelusive,
        keyIsCopyrighted: submittedClaim.isCopyrighted,
        keyDescription: submittedClaim.description,
        keySeverity: submittedClaim.severity,
        keyDate: submittedClaim.date,
        keyStatus: submittedClaim.status,
      };
      documentReference.set(map); // BDD Action
      // print('Claim creation succeed in api');
    } catch(error) {
      // print('Claim creation failed in api');
      return error;
    }
  }

  updateClaimStatus(ClaimNotifier claimNotifier, Claim claim, String statusUpdate) {
      Map<String, dynamic> data = {};
      // print('Map ok');
      data = claim.toMap();
      // print('Data ok');
      data[keyStatus] = statusUpdate;
      // print(statusUpdate);
      Claim _updatedClaim;
      _updatedClaim = Claim.fromMap(data);
      // print(_updatedClaim.cid);
      updateClaim(_updatedClaim, data); // BDD action
      claimNotifier.updateClaimInList(_updatedClaim); // Client action
      // print('Updating claim status succeed in api');
  }

  updateClaim(Claim claim, Map<String, dynamic> data) {
    _firestore.collection(keyClaims).doc(claim.cid).update(data);
  }

  // EVENTS

  Future<void>getEventsToCome(EventNotifier eventNotifier) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(keyEvents).orderBy(keyDate, descending: false).where(keyDate, isGreaterThan: DateTime.now().millisecondsSinceEpoch).get();
      List<Event> _eventList = [];
      snapshot.docs.forEach((document) {
        Event event = Event.fromMap(document.data());
        _eventList.add(event);
      });
      eventNotifier.eventList = _eventList;
      // print('Get events succeed in api');
    } catch(error) {
      // print('Get events failed in api');
      return error;
    }
  }

  Future<void> getEventsFromPast(EventNotifier eventNotifier) async {
    try{
      QuerySnapshot snapshot = await _firestore.collection(keyEvents).orderBy(keyDate, descending: false).where(keyDate, isLessThan: DateTime.now().millisecondsSinceEpoch).get();
      List<Event> _eventsFromPastList = [];
      snapshot.docs.forEach((document) {
        Event event = Event.fromMap(document.data());
        _eventsFromPastList.add(event);
      });
      eventNotifier.eventsFromPastList = _eventsFromPastList;
      // print('Get events succeed in api');
    } catch(error) {
      return error;
    }
  }


  updateEvent(Event event, Map<String, dynamic> data) {
    _firestore.collection(keyEvents).doc(event.eid).update(data);
  }

  Future<void>deleteEvent(EventNotifier eventNotifier) async {
    try {
      // Delete image if necessary
      if(eventNotifier.currentEvent.imageUrl != null && eventNotifier.currentEvent.imageUrl != ''){
        deleteEventPicture(eventNotifier.currentEvent); // STORAGE action
      }
      // Delete participants if necessary
      await _firestore.collection(keyEvents).doc(eventNotifier.currentEvent.eid).collection('participants').get().then((snapshot) {
        for(DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
      // Delete in BDD
      _firestore.collection(keyEvents).doc(eventNotifier.currentEvent.eid).delete(); // BDD action
      // Delete locally
      eventNotifier.deleteEvent(eventNotifier.currentEvent); // Client action
      // print('Delete event succeed in api');
    } catch (error) {
      // print('Delete event failed in api');
      return error;
    }
  }


  Future<void>uploadEvent(EventNotifier eventNotifier, Event submittedEvent, File backImage) async {
    if(submittedEvent.eid != null) {
      // UPDATE EXISTING STORY
      try {
        Event _updatedEvent;
        Map<String, dynamic> map = {
          keyEid: submittedEvent.eid,
          keyTitle: submittedEvent.title,
          keyDescription: submittedEvent.description,
          keyDate: submittedEvent.date,
          keyAddress: submittedEvent.address,
          keyPrice: submittedEvent.price,
          keyCapacity: submittedEvent.capacity,
          keyField: submittedEvent.field,
          keyReferent: submittedEvent.referent,
        };
        if (backImage != null) {
          Reference ref = storageEvent.child(submittedEvent.eid);
          String backgroundImageUrl = await addImage(backImage, ref);
          map[keyImageUrl] = backgroundImageUrl;
        } else {
          map[keyImageUrl] = submittedEvent.imageUrl;
        }
        _updatedEvent = Event.fromMap(map);
        updateEvent(_updatedEvent, map); // BDD action
        eventNotifier.updateCurrentEventInList(_updatedEvent); // Client action for list display
        eventNotifier.currentEvent = _updatedEvent; // Client action for single event display
        // print('Event update succeed in api');
      } catch(error) {
        // print('Event update failed in api');
        return error;
      }
    } else {
      // NEW EVENT
      try {
        Event _newEvent;
        DocumentReference documentReference = _firestore.collection(keyEvents).doc();
        Map<String, dynamic> map = {
          keyEid: documentReference.id,
          keyTitle: submittedEvent.title,
          keyDescription: submittedEvent.description,
          keyDate: submittedEvent.date,
          keyAddress: submittedEvent.address,
          keyPrice: submittedEvent.price,
          keyCapacity: submittedEvent.capacity,
          keyField: submittedEvent.field,
          keyReferent: submittedEvent.referent,
        };
        if (backImage != null) {
          Reference ref = storageEvent.child(documentReference.id);
          String backgroundImageUrl = await addImage(backImage, ref);
          map[keyImageUrl] = backgroundImageUrl;
        }
        _newEvent = Event.fromMap(map);
        documentReference.set(map); // BDD Action
        eventNotifier.addEvent(_newEvent); // Client action
        // print('Event creation succeed in api');
      } catch(error) {
        // print('Event creation failed in api');
        return error;
      }
    }
  }

  Future<void>getEventReferent(EventNotifier eventNotifier) async {
    try{
      DocumentSnapshot snapshot = await _firestore.collection(keyMembers).doc(eventNotifier.currentEvent.referent).get();
      if(snapshot != null) {
        Member _eventReferent;
        Map<String, dynamic> data = snapshot.data();
        _eventReferent = Member.fromMap(data);
        eventNotifier.currentReferent = _eventReferent; // Client side action
      }
      // print('Get event referent succeed in api');
    } catch (error) {
      // print('Get event referent failed in api');
    }
  }

  // => Participants

  Future<void>getParticipants(EventNotifier eventNotifier) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(keyEvents).doc(eventNotifier.currentEvent.eid).collection(keyParticipants).get();
      List<Member> _participantsList = [];
      if(snapshot != null) {
        snapshot.docs.forEach((document) async {
          try {
            DocumentSnapshot doc = await _firestore.collection(keyMembers).doc(document.id).get();
            if(doc != null) {
              // print('Doc participant not null in api');
              Member _eventParticipant;
              Map<String, dynamic> data = doc.data();
              _eventParticipant = Member.fromMap(data);
              _participantsList.add(_eventParticipant);
              // print('Participant added to local list');
            }
            // print(eventNotifier.eventParticipantsList.length);
            eventNotifier.eventParticipantsList = _participantsList;
            // print('Get participant member info succeed in api');
          } catch (error) {
            // print('Get participant member info failed in api');
            return error;
          }
        });
      }
      // print('Get event participants succeed in api');
    } catch (error) {
      // print('Get event participants failed in api');
      return error;
    }
  }

  Future<void>getEventParticipants(EventNotifier eventNotifier) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(keyEvents).doc(eventNotifier.currentEvent.eid).collection(keyParticipants).get();
      List<Member> _participantList = [];
      if(snapshot != null) {
        snapshot.docs.forEach((document) {
          Member _participant = Member.fromMap(document.data());
          _participantList.add(_participant);
        });
      }
      eventNotifier.eventParticipantsList = _participantList;
      // print('Get event participants succeed in api');
    } catch (error) {
      // print('Get event participants failed in api');
      return error;
    }
  }

  Future<void> addOrRemoveParticipantToEvent(EventNotifier eventNotifier, MemberNotifier memberNotifier) async {
    // Case : member has already subscribed to the event : delete Array and SubDoc
    if(memberNotifier.currentMember.events.contains(eventNotifier.currentEvent.eid)) {
      // BDD actions
      await memberNotifier.currentMember.ref.update({keyEvents: FieldValue.arrayRemove([eventNotifier.currentEvent.eid])}); // Delete Event ID in Current member events
      await _firestore.collection(keyEvents).doc(eventNotifier.currentEvent.eid).collection(keyParticipants).doc(memberNotifier.currentMember.uid).delete(); // Delete Current Member in Current event participants
      // Client actions
      memberNotifier.removeEventEidInCurrentMember(eventNotifier.currentEvent.eid); // Delete event id in Current member events
      eventNotifier.removeParticipant(memberNotifier.currentMember); // Remove Current member from Event Participant List
      // print('Current member has been removed from this event participants in api');
    } else { // Case : member has not subscribed yet to the event : add to Array and create SubDoc
      // BDD actions
      Map<String, dynamic> map = {};
      map = memberNotifier.currentMember.toMap();
      await memberNotifier.currentMember.ref.update({keyEvents: FieldValue.arrayUnion([eventNotifier.currentEvent.eid])}); // Add Event Id in Current member events
      await _firestore.collection(keyEvents).doc(eventNotifier.currentEvent.eid).collection(keyParticipants).doc(memberNotifier.currentMember.uid).set(map); // Create Participant in the event Participants subcollection
      // Client actions
      memberNotifier.addEventEidToCurrentMember(eventNotifier.currentEvent.eid); // Add event id in Current member events
      eventNotifier.addParticipant(memberNotifier.currentMember); // Add Current member to event participants list
      // print('Current member has been added from this event participants in api');
    }
  }


  // ITEMS

  Future<void>getItems(ItemNotifier itemNotifier) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(keyItems).orderBy(keyName, descending: false).get();
      List<Item> _itemsList = [];
      if(snapshot != null) {
        snapshot.docs.forEach((document) {
          Map<String, dynamic> map = document.data();
          Item item = Item.fromMap(map);
          _itemsList.add(item);
        });
      }
      itemNotifier.itemsList = _itemsList;
      // print('Get items succeed in api');
    } catch (error) {
      // print('Get items failed in api');
      return error;
    }
  }

  void updateItem(Item item, Map<String, dynamic> data) {
    _firestore.collection(keyItems).doc(item.iId).update(data);
  }

  Future<void>deleteItem(ItemNotifier itemNotifier, MemberNotifier memberNotifier) async {
    try {
      // Delete icon in Firestore
      if(itemNotifier.currentItem.iconImageUrl != null && itemNotifier.currentItem.iconImageUrl != '') {
        deleteItemIconPicture(itemNotifier.currentItem);
      }
      // Delete portfolio in Firestore
      if(itemNotifier.currentItem.imageOneUrl != null && itemNotifier.currentItem.imageOneUrl != '') {
        deleteItemPortfolioPicture(itemNotifier.currentItem, 1);
      }
      if(itemNotifier.currentItem.imageTwoUrl != null && itemNotifier.currentItem.imageTwoUrl != '') {
        deleteItemPortfolioPicture(itemNotifier.currentItem, 2);
      }
      if(itemNotifier.currentItem.imageThreeUrl != null && itemNotifier.currentItem.imageThreeUrl != '') {
        deleteItemPortfolioPicture(itemNotifier.currentItem, 3);
      }
      // Delete item in BDD
      _firestore.collection(keyItems).doc(itemNotifier.currentItem.iId).delete(); // BDD action
      // Delete item in client
      itemNotifier.deleteItem(itemNotifier.currentItem); // Client action
      // Delete item.Iid in owner items list and item in current member items
      if(memberNotifier.currentMember.items.contains(itemNotifier.currentItem.iId)) {
        _firestore.collection(keyMembers).doc(itemNotifier.currentItem.owner).update({keyItems: FieldValue.arrayRemove([itemNotifier.currentItem.iId])}); // BDD action
        memberNotifier.removeItemIidInCurrentMember(itemNotifier.currentItem.iId); // Client action
        memberNotifier.deleteItemInCurrentMemberItems(itemNotifier.currentItem); // Client action
      }
      // print('Delete story succeed in api');
    } catch (error) {
      // print('Delete story failed in api');
      return error;
    }
  }

  Future<void>uploadItem(ItemNotifier itemNotifier, Item submittedItem, File imageOneFile, File imageTwoFile, File imageThreeFile, File iconFile, MemberNotifier memberNotifier) async {
    if(submittedItem.iId != null) {
      // UPDATE EXISTING ITEM
      try {
        Item _updatedItem;
        Map<String, dynamic> map = {
          keyIid: submittedItem.iId,
          keyName: submittedItem.name,
          keyDescription: submittedItem.description,
          keyLoanTerm: submittedItem.loanTerm,
          keyOwner: submittedItem.owner,
          keyBorrower: submittedItem.borrower,
          keyPrice: submittedItem.price,
          keyState: submittedItem.state,
        };
        // Portfolio
        if(imageOneFile != null) {
          Reference ref = storageItems.child(keyPortfolio).child(submittedItem.iId).child('${submittedItem.iId}1');
          await addImage(imageOneFile, ref).then((value) => map[keyImageOneUrl] = value);
        } else {
          map[keyImageOneUrl] = submittedItem.imageOneUrl; // Unnecessary for BDD update but mandatory for CLIENT display
        }
        if(imageTwoFile != null) {
          Reference ref = storageItems.child(keyPortfolio).child(submittedItem.iId).child('${submittedItem.iId}2');
          await addImage(imageTwoFile, ref).then((value) => map[keyImageTwoUrl] = value);
        } else {
          map[keyImageTwoUrl] = submittedItem.imageTwoUrl; // Unnecessary for BDD update but mandatory for CLIENT display
        }
        if(imageThreeFile != null) {
          Reference ref = storageItems.child(keyPortfolio).child(submittedItem.iId).child('${submittedItem.iId}3');
          await addImage(imageThreeFile, ref).then((value) => map[keyImageThreeUrl] = value);
        } else {
          map[keyImageThreeUrl] = submittedItem.imageThreeUrl; // Unnecessary for BDD update but mandatory for CLIENT display
        }
        // Icon image
        if(iconFile != null) {
          Reference ref = storageItems.child(keyIconImage).child(submittedItem.iId);
          await addImage(iconFile, ref).then((value) => map[keyIconImageUrl] = value);
        } else {
          map[keyIconImageUrl] = submittedItem.iconImageUrl; // For client display
        }
        // Upload final steps
        _updatedItem = Item.fromMap(map);
        updateItem(_updatedItem, map); // BDD item update
        itemNotifier.updateCurrentItemInList(_updatedItem); // CLIENT update in items list
        itemNotifier.currentItem = _updatedItem; // CLIENT update for single item
        memberNotifier.updateItemInCurrentMemberItems(_updatedItem); // CLIENT update in member items list
        // print('Update item succeed in api');
      } catch(error) {
        // print('Update item failed in api');
        return error;
      }
    } else {
      // NEW ITEM
      try {
        Item _newItem;
        DocumentReference documentReference = _firestore.collection(keyItems).doc();
        Map<String, dynamic> map = {
          keyIid: documentReference.id,
          keyName: submittedItem.name,
          keyDescription: submittedItem.description,
          keyIconImageUrl: submittedItem.iconImageUrl,
          keyImageOneUrl: submittedItem.imageOneUrl,
          keyImageTwoUrl: submittedItem.imageTwoUrl,
          keyImageThreeUrl: submittedItem.imageThreeUrl,
          keyLoanTerm: submittedItem.loanTerm,
          keyOwner: submittedItem.owner,
          keyBorrower: '',
          keyPrice: submittedItem.price,
          keyState: submittedItem.state,
        };
        // Portfolio
        if(imageOneFile != null) {
          Reference ref = storageItems.child(keyPortfolio).child(documentReference.id).child('${documentReference.id}1');
          await addImage(imageOneFile, ref).then((value) => map[keyImageOneUrl] = value);
        }
        if(imageTwoFile != null) {
          Reference ref = storageItems.child(keyPortfolio).child(documentReference.id).child('${documentReference.id}2');
          await addImage(imageTwoFile, ref).then((value) => map[keyImageTwoUrl] = value);
        }
        if(imageThreeFile != null) {
          Reference ref = storageItems.child(keyPortfolio).child(documentReference.id).child('${documentReference.id}3');
          await addImage(imageThreeFile, ref).then((value) => map[keyImageThreeUrl] = value);
        }
        // Icon image
        if(iconFile != null) {
          Reference ref = storageItems.child(keyIconImage).child(documentReference.id);
          await addImage(iconFile, ref).then((value) => map[keyIconImageUrl] = value);
        }
        // Upload final steps
        _newItem = Item.fromMap(map);
        documentReference.set(map); // BDD action
        itemNotifier.addItem(_newItem); // Client action
        await addItemInOwnerItems(memberNotifier, _newItem); // Add item to owner's items list
        // print('Create item succeed in api');
      } catch(error) {
        // print('Create item failed in api');
        return error;
      }
    }
  }

  Future<void> addItemInOwnerItems(MemberNotifier memberNotifier, Item addedItem) async {
    try {
      await _firestore.collection(keyMembers).doc(memberNotifier.currentMember.uid).update({keyItems: FieldValue.arrayUnion([addedItem.iId])}); // BDD action
      /*
      // CASE NEW FIELD NEEDED : If Member.items is null, adding an item is impossible
      // Need to instance member.items as an empty list
      if(memberNotifier.currentMember.items == null) {
        Member _owner;
        Map<String, dynamic> _memberMap = {};
        _memberMap = memberNotifier.currentMember.toMap();
        _memberMap[keyItems] = []; // Empty list init instead of null
        _owner = Member.fromMap(_memberMap);
        memberNotifier.currentMember = _owner; // Client action
      }
       */
      memberNotifier.addItemIidToCurrentMember(addedItem.iId); // Client side action
      memberNotifier.addItemToCurrentMemberItemsList(addedItem); // Client side action
    } catch (error) {
      return error;
    }
  }

  void uploadItemLendingParameters(ItemNotifier itemNotifier, MemberNotifier memberNotifier, Item submittedItem, Member submittedBorrower) {
    try{
      Item _updatedItem;
      Map<String, dynamic> map = {};
      map = submittedItem.toMap();
      if(submittedBorrower != null) {
        map[keyBorrower] = submittedBorrower.uid;
      } else {
        map[keyBorrower] = '';
      }
      // Upload final steps
      _updatedItem = Item.fromMap(map);
      updateItem(_updatedItem, map); // BDD item update
      itemNotifier.updateCurrentItemInList(_updatedItem); // Client update in items list
      itemNotifier.currentItem = _updatedItem; // Client action for single display
      itemNotifier.currentBorrower = submittedBorrower; // Client action for single display
      memberNotifier.updateItemInCurrentMemberItems(_updatedItem); // CLIENT update in member items list
      // print('Updating item lending succeed in API');
    } catch (error) {
      // print('Updating item lending failed in API');
      return error;
    }
  }


  Future<void>getItemOwner(ItemNotifier itemNotifier) async {
    try{
      DocumentSnapshot snapshot = await _firestore.collection(keyMembers).doc(itemNotifier.currentItem.owner).get();
      if(snapshot != null) {
        Member _itemOwner;
        Map<String, dynamic> data = snapshot.data();
        _itemOwner = Member.fromMap(data);
        itemNotifier.currentOwner = _itemOwner; // Client side action
      }
      // print('Get event referent succeed in api');
    } catch (error) {
      // print('Get event referent failed in api');
      return error;
    }
  }

  Future<void>getItemBorrower(ItemNotifier itemNotifier) async {
    if(itemNotifier.currentItem.borrower != null && itemNotifier.currentItem.borrower != '') {
      try{
        DocumentSnapshot snapshot = await _firestore.collection(keyMembers).doc(itemNotifier.currentItem.borrower).get();
        if(snapshot != null) {
          Member _itemBorrower;
          Map<String, dynamic> data = snapshot.data();
          _itemBorrower = Member.fromMap(data);
          itemNotifier.currentBorrower = _itemBorrower; // Client side action
        }
        // print('Get item borrower succeed in api');
      } catch (error) {
        // print('Get item borrower failed in api');
        return error;
      }
    } else {
      Member _itemBorrower; // No instance, null Member ?
      // _itemBorrower = Member(); // Provide an instance with null fields but non null member
      itemNotifier.currentBorrower = _itemBorrower; // Client side action
    }
  }

  Future<void>getCurrentMemberItemsList(MemberNotifier memberNotifier) async {
    try {
      if(memberNotifier.currentMember.items.isNotEmpty) {
        List<Item> _memberItemsList = [];
        for(String itemIid in memberNotifier.currentMember.items) {
          DocumentSnapshot snapshot = await _firestore.collection(keyItems).doc(itemIid).get();
          Item _currentItem;
          if(snapshot != null) {
            Map<String, dynamic> data = snapshot.data();
            _currentItem = Item.fromMap(data);
            _memberItemsList.add(_currentItem);
          }
        }
        _memberItemsList.sort((a,b) => a.name.compareTo(b.name));
        memberNotifier.currentMemberItems = _memberItemsList;
        // print('Get current member items list OK');
      }
    } catch (error) {
      // print('Get current member items list KO');
      return error;
    }
  }


  // STORIES

  Future<void>getStories(StoryNotifier storyNotifier) async {
      try {
        QuerySnapshot snapshot = await _firestore.collection(keyStories).orderBy(keyEndTime, descending: true).get();
        List<Story> _storyList = [];
        snapshot.docs.forEach((document) {
          Story story = Story.fromMap(document.data());
            _storyList.add(story);
        });
        storyNotifier.storyList = _storyList;
        // print('Get stories succeed in api');
      } catch (error) {
        // print('Get stories failed in api');
        return error;
      }
  }

  updateStory(Story story, Map<String, dynamic> data) {
    _firestore.collection(keyStories).doc(story.sid).update(data);
  }


  Future<void>deleteStory(StoryNotifier storyNotifier) async {
    try {
      // Portfolio delete
      if(storyNotifier.currentStory.picturesUrl != null && storyNotifier.currentStory.picturesUrl.isNotEmpty) {
        deleteStoryPortfolioPictures(storyNotifier.currentStory);
      }
      _firestore.collection(keyStories).doc(storyNotifier.currentStory.sid).delete(); // BDD delete
      storyNotifier.deleteStory(storyNotifier.currentStory); // Client
      // print('Delete story succeed in api');
    } catch (error) {
      // print('Delete story failed in api');
    }
  }


  Future<void>uploadStory(StoryNotifier storyNotifier, Story submittedStory) async {
    if(submittedStory.sid != null) {
      // UPDATE EXISTING STORY
      try {
        Story _updatedStory;
        Map<String, dynamic> map = {
          keySid: submittedStory.sid,
          keyTitle: submittedStory.title,
          keyDescription: submittedStory.description,
          keyEndTime: submittedStory.endtime,
          keySpot: submittedStory.spot,
          keyPicturesUrl: submittedStory.picturesUrl,
          keyField: submittedStory.field,
          keyWriter: submittedStory.writer,
        };
        _updatedStory = Story.fromMap(map);
        updateStory(_updatedStory, map); // BDD action
        storyNotifier.updateCurrentStoryInList(_updatedStory); // Client action for list display
        storyNotifier.currentStory = _updatedStory; // Client action for single story display
        // print('Update story succeed in api');
      } catch(error) {
        // print('Update story failed in api');
        return error;
      }
    } else {
      // NEW STORY
      try {
        Story _newStory;
        DocumentReference documentReference = _firestore.collection(keyStories).doc();
        List<dynamic> picturesUrl = [];
        Map<String, dynamic> map = {
          keySid: documentReference.id,
          keyTitle: submittedStory.title,
          keyDescription: submittedStory.description,
          keyEndTime: submittedStory.endtime,
          keySpot: submittedStory.spot,
          keyPicturesUrl: picturesUrl,
          keyField: submittedStory.field,
          keyWriter: submittedStory.writer,
        };
        _newStory = Story.fromMap(map);
        documentReference.set(map); // BDD action
        storyNotifier.addStory(_newStory); // Client action
        // print('Create story succeed in api');
      } catch(error) {
        // print('Create story failed in api');
        return error;
      }
    }
  }

  Future<void>uploadStoryPictures(StoryNotifier storyNotifier, Story submittedStory, List<Asset> assetsList) async {
    try {
      Story _updatedStory;
      Map<String, dynamic> map = {};
      map = submittedStory.toMap();
      if(assetsList != null && assetsList.isNotEmpty) {
        // Delete existing pictures in Storage
        deleteStoryPortfolioPictures(submittedStory);
        // Add images from files List
        List<dynamic> _imagesUrl = [];
        for(int i = 0; i < assetsList.length; i++) {
          await addPortfolioImage(assetsList[i], submittedStory, i).then((value) => _imagesUrl.add(value));
        }
        map[keyPicturesUrl] = _imagesUrl;
      }
      // Upload final steps
      _updatedStory = Story.fromMap(map);
      updateStory(_updatedStory, map); // BDD story update
      storyNotifier.currentStory = _updatedStory; // Client update for single story
      storyNotifier.updateCurrentStoryInList(_updatedStory); // Client updated in stories list
      // print('Upload pictures succeed');
    } catch(error) {
      // print('Upload pictures failed');
      return error;
    }
  }

  //ACTIVITIES

  Future<void>getActivities(ActivityNotifier activityNotifier) async {
      try {
        QuerySnapshot snapshot = await _firestore.collection(keyActivities).orderBy(keyName).get();
        List<Activity> _activityList = [];
        snapshot.docs.forEach((document) {
          Activity activity = Activity.fromMap(document.data());
          _activityList.add(activity);
        });
        activityNotifier.activityList = _activityList;
        // print('Get activities succeed in api');
      } catch(error) {
        // print('Get activities failed in api');
        return error;
      }
  }

  updateActivity(Activity activity, Map<String, dynamic> data) {
    _firestore.collection(keyActivities).doc(activity.aid).update(data);
  }

  Future<void>uploadActivity(ActivityNotifier activityNotifier, Activity submittedActivity, File backImage, File iconImage, Member rootLeader) async {
    if(submittedActivity.aid != null) {
      // UPDATE EXISTING ACTIVITY case : activity already exists
      try {
        Activity _updatedActivity;
        Map<String, dynamic> map = {
          keyAid: submittedActivity.aid,
          keyName: submittedActivity.name,
          keyLeader: submittedActivity.leader,
          keyCategory: submittedActivity.category,
        };
        if (backImage != null) {
          Reference ref = storageActivities.child('backgroundImage').child(submittedActivity.aid);
          String backgroundImageUrl = await addImage(backImage, ref);
          map[keyBackgroundImageUrl] = backgroundImageUrl;
        } else {
          map[keyBackgroundImageUrl] = submittedActivity.backgroundImageUrl;
        }
        if (iconImage != null) {
          Reference ref = storageActivities.child('iconImage').child(submittedActivity.aid);
          String iconImageUrl = await addImage(iconImage, ref);
          map[keyIconImageUrl] = iconImageUrl;
        } else {
          map[keyIconImageUrl] = submittedActivity.iconImageUrl;
        }
        _updatedActivity = Activity.fromMap(map);
        updateActivity(_updatedActivity, map); // BDD
        activityNotifier.updateCurrentActivityInList(_updatedActivity); // Client for list display
        activityNotifier.currentActivity = _updatedActivity; // Client for single activity display
        // print('Update activity succeed in api');
      } catch(error) {
        // print('Update activity failed in api');
        return error;
      }
    } else {
      // NEW ACTIVITY case : create a new activity
      try {
        Activity _newActivity;
        DocumentReference documentReference = _firestore.collection(keyActivities).doc();
        String _backgroundImageUrl = '';
        String _iconImageUrl = '';
        Map<String, dynamic> map = {
          keyAid: documentReference.id,
          keyName: submittedActivity.name,
          keyCategory: submittedActivity.category,
          keyLeader : submittedActivity.leader,
          keyIconImageUrl: _iconImageUrl,
          keyBackgroundImageUrl: _backgroundImageUrl,
        };
        if (backImage != null) {
          Reference ref = storageActivities.child('backgroundImage').child(documentReference.id);
          String backgroundImageUrl = await addImage(backImage, ref);
          map[keyBackgroundImageUrl] = backgroundImageUrl;
        }
        if (iconImage != null) {
          Reference ref = storageActivities.child('iconImage').child(documentReference.id);
          String iconImageUrl = await addImage(iconImage, ref);
          map[keyIconImageUrl] = iconImageUrl;
        }
        _newActivity = Activity.fromMap(map);
        documentReference.set(map); // BDD
        activityNotifier.addActivity(_newActivity); // Client
        // Add rootLeader as expert in the activity
        try{
          Map<String, dynamic> expertMap = {};
          expertMap[keyExId] = rootLeader.uid;
          expertMap[keyValuation] = 3;
          documentReference.collection(keyExperts).doc(rootLeader.uid).set(expertMap); // BDD
          // print('Adding expert succeed in api');
        } catch (error) {
          // print('Adding expert failed in api');
        }
      } catch(error) {
        // print('Adding activity error');
        return error;
      }
    }
  }

  Future<void>deleteActivity(ActivityNotifier activityNotifier) async {
    try {
      if(activityNotifier.currentActivity.backgroundImageUrl != null && activityNotifier.currentActivity.backgroundImageUrl != ''){
        deleteActivityBackPicture(activityNotifier.currentActivity);
      }
      if(activityNotifier.currentActivity.iconImageUrl != null && activityNotifier.currentActivity.iconImageUrl != ''){
        deleteActivityIconPicture(activityNotifier.currentActivity);
      }
      await _firestore.collection(keyActivities).doc(activityNotifier.currentActivity.aid).collection(keyExperts).get().then ((snapshot) {
        for(DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
      _firestore.collection(keyActivities).doc(activityNotifier.currentActivity.aid).delete(); // BDD
      activityNotifier.deleteActivity(activityNotifier.currentActivity); // Client
      // print('Activity deleted succeed in api');
    } catch (error) {
      // print('Activity deleted failed in api');
      return error;
    }
  }

  Future<void>getActivityExperts(ActivityNotifier activityNotifier) async {
    try{
      QuerySnapshot snapshot = await _firestore.collection(keyActivities).doc(activityNotifier.currentActivity.aid).collection(keyExperts).orderBy(keyValuation).get();
      List<Leader> _activityLeaders = [];
      if(snapshot != null) {
        snapshot.docs.forEach((document) async {
          Map<String, dynamic> _expertMap = document.data();
          try {
            DocumentSnapshot doc = await _firestore.collection(keyMembers).doc(document.id).get();
            if(doc != null) {
              // print('Doc not null in api');
              Leader _activityLeader;
              Map<String, dynamic> data = doc.data();
              data[keyValuation] = _expertMap[keyValuation];
              _activityLeader = Leader.fromMap(data);
              _activityLeaders.add(_activityLeader);
              // print('Leader added to local list');
            }
            activityNotifier.activityLeaders = _activityLeaders; // Client
          } catch(error) {
            // print('Get activity experts failed in api');
            return error;
          }
        });
        // print('Get activity experts succeed in api');
      }
    } catch (error) {
      // print('Get activity experts failed in api');
      return error;
    }
  }


  // STORAGE ACTIONS

  final storageMember = _firestorage.child(keyMembers); // Subfolders of member's related pictures
  final storageEvent = _firestorage.child(keyEvents); // Subfolders of event's related pictures
  final storageStories = _firestorage.child(keyStories); // Subfolders of stories's related pictures
  final storageActivities = _firestorage.child(keyActivities); // Subfolders of activities related pictures
  final storageItems = _firestorage.child(keyItems); // Subfolders of activities related pictures

  // Add image to storage
  Future<String> addImage(File file, Reference ref) async {
    try {
      await ref.putFile(file);
      String urlString = await ref.getDownloadURL();
      return urlString;
    } catch (error) {
      // print(error);
      return error;
    }
  }

  Future<String> addPortfolioImage(Asset asset, Story story, int index) async {
    ByteData byteData = await asset.getByteData(); // requestOriginal is being deprecated
    List<int> imageData = byteData.buffer.asUint8List();
    Reference ref = storageStories.child(keyPortfolio).child(story.sid).child('${story.sid}${index.toString()}');
    UploadTask uploadTask = ref.putData(imageData);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    // print(taskSnapshot.ref.getDownloadURL());
    return taskSnapshot.ref.getDownloadURL();
  }


  // => Events
  void deleteEventPicture(Event event) {
    if(event != null && event.imageUrl != null) {
      Reference ref = storageEvent.child(event.eid);
      ref.delete();
    } else {
      return null;
    }
  }

  void deleteStoryPortfolioPictures(Story story) {
    if(story != null && story.picturesUrl.isNotEmpty) {
      for(int i = 0; i < story.picturesUrl.length; i ++) {
        Reference ref = storageStories.child(keyPortfolio).child(story.sid).child('${story.sid}${i.toString()}');
        ref.delete();
      }
      // print('Previous images deleted');
    } else {
      // print('Nothing to delete');
      return null;
    }
  }

  // => Activity
  void deleteActivityBackPicture(Activity activity) {
    Reference ref = storageActivities.child('backgroundImage').child(activity.aid);
    ref.delete();
  }

  void deleteActivityIconPicture(Activity activity) {
    Reference ref = storageActivities.child('iconImage').child(activity.aid);
    ref.delete();
  }

  void deleteItemIconPicture(Item item) {
    Reference ref = storageItems.child(keyIconImage).child(item.iId);
    ref.delete();
  }

  void deleteItemPortfolioPicture(Item item, int index) {
    Reference ref = storageItems.child(keyPortfolio).child(item.iId).child('${item.iId}$index');
    ref.delete();
  }







}