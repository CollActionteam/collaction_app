import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/domain/crowdaction/participant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Participant tParticipant;

  List<TopParticipant> generateTopParticipants(int num) {
    late int topParticipantCnt;
    if (num < 3) {
      topParticipantCnt = num;
    } else {
      topParticipantCnt = 3;
    }
    return List.generate(
      topParticipantCnt,
      (i) => TopParticipant(userId: 'tUser$i', name: 'tName$i'),
    );
  }

  setUp(() {
    tParticipant = Participant('tPhoto', 'tName');
  });
  
  test('Participant test', () {
    expect(tParticipant.name, 'tName');
    expect(tParticipant.photo, 'tPhoto');
  });

  test('Test sample participants data', () {
    expect(sampleParticipants.length, 3);
    for (final sample in sampleParticipants) {
      expect(sample.runtimeType, Participant);
    }
  });

  test('Testing participants page participants ', () {
    expect(participantsPageParticipants.length, 20);

    for (int i = 0; i < 20; i++) {
      if (i.isEven) {
        expect(participantsPageParticipants[i].name, 'Barbara');
        expect(
          participantsPageParticipants[i].photo,
          'https://source.unsplash.com/mEZ3PoFGs_k/500x500',
        );
      } else {
        expect(
          participantsPageParticipants[i].name,
          'Barbara With A Very Long Name That Spans Two Lines',
        );
        expect(
          participantsPageParticipants[i].photo,
          'https://source.unsplash.com/L2dTmhQzx4Q/500x500',
        );
      }
    }
  });

  group('Testing ParticipantX title generation extension', () {
    List<TopParticipant> tTopParticipants;
    int totalParticipants;
    String title;
    
    test('When top participants length>3 and total participants > 3', () {
      tTopParticipants = generateTopParticipants(3);
      totalParticipants = 3;
      title = tTopParticipants.title(totalParticipants);
      expect(title, 'tName0, tName1 and ${totalParticipants - 2} others!');
    });

    test('When Top participants length = 1', () {
      tTopParticipants = generateTopParticipants(1);
      totalParticipants = 3;
      title = tTopParticipants.title(totalParticipants);
      expect(title, 'tName0');
    });

    test('When Top participants length = 2', () {
      tTopParticipants = generateTopParticipants(2);
      totalParticipants = 5;
      title = tTopParticipants.title(totalParticipants);
      expect(title, 'tName0 and tName1');
    });
  });
}
