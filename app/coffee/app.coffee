fingerType = ''

(window.controller = new Leap.Controller)
    .use('transform', {
        scale: 4,
        quaternion: ->
            q = new THREE.Quaternion()
            q.setFromEuler(
                new THREE.Euler(0, Math.PI * parseFloat(0.5,10) , 0)
                )
            return q
    })
    .use('riggedHand', {
        boneColors: (boneMesh, leapHand)->
            if (boneMesh.name.indexOf('Finger_0') == 0) || (boneMesh.name.indexOf('Finger_4') == 0)
                return {
                    hue: 0.6,
                    saturation: leapHand.pinchStrength,
                    # hexString: '#ffcc00'
              }
            if (boneMesh.name.indexOf('Finger_1') == 0) || (boneMesh.name.indexOf('Finger_5') == 0)
                return {
                    hue: 0.3,
                    saturation: leapHand.pinchStrength,
                    # hexString: '#ffcc00'
              }
            if boneMesh.name.indexOf('Finger_3') == 0
                return {
                    hue: 0.9,
                    saturation: leapHand.pinchStrength,
                    # hexString: '#ffcc00'
              }
        })
    .connect()
    .on('frame', (frame) ->
        frame.hands.forEach((hand, index) ->
            if (hand.grabStrength == 1.0)
                fingerType = 'ROCK'
            else if hand.middleFinger.extended and hand.indexFinger.extended and !hand.pinky.extended
                fingerType = 'SCISSORS'
            else if (hand.grabStrength == 0.0)
                fingerType = 'PAPER'

            $('#type').text(fingerType)
        )
    )
