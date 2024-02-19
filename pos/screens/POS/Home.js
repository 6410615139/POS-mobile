import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View, TouchableOpacity } from 'react-native';
import { Input, NativeBaseProvider, Button, Icon, Box, Image, AspectRatio } from 'native-base';
import { useNavigation } from '@react-navigation/native';

function Home() {
    const navigation = useNavigation();

    return (
        <View style={styles.container}>
            <Text style={styles.title}>Point of Sale</Text>
            <Text>Open up App.js to start working on your app!</Text>
            <StatusBar style="auto" />
            <TouchableOpacity onPress={() => navigation.navigate('Login')} ><Text style={styles.botton}>Back to Login</Text></TouchableOpacity>
        </View>
    );
}

export default () => {
    return (
        <NativeBaseProvider>
            <Home />
        </NativeBaseProvider>
    )
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#fff',
        alignItems: 'center',
        justifyContent: 'center',
    },
    title: {
        fontSize: 50,
    },
    botton: {
        fontWeight: 'bold',
    },
});
