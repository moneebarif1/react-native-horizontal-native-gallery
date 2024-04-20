import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import { showLightbox } from 'react-native-horizontal-native-gallery';

const imageIds = [
  100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200,
];
const images = new Array(10).fill(0).map((_, index) => {
  return {
    imageUrl: `https://picsum.photos/id/${imageIds[index]}/${1600}/${1200}`,
    text: 'Testing',
  };
});

export default function App() {
  React.useEffect(() => {
    showLightbox(images, 0);
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
