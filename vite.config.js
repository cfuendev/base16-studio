import { imba } from 'vite-plugin-imba';
import { defineConfig } from 'vite';
import monacoEditorPlugin from 'vite-plugin-monaco-editor';

export default defineConfig({
	base: '',
	plugins: [
		imba(),
		//@ts-ignore
		monacoEditorPlugin.default({
			languageWorkers: ['json', 'editorWorkerService'],
			customWorkers: []
		})
	],
});
